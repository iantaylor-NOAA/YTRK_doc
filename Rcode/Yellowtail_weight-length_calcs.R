### weight-length relationship for Yellowtail
stop("don't source this file")

if (system("hostname", intern=TRUE) %in% c("NWCLW04223033") ){
  YTdir <- "C:/SS/Yellowtail/Yellowtail2017"
  YTdir.NWFSC <- file.path(YTdir, "Data/NWFSCsurvey")
  tridir <- file.path(YTdir, "Data/AKsurveys")
  HLdir <- file.path(YTdir, "Data/H&L")
}

# get ages from NWFSC survey (with lengths and weights) from separate CSV
# files that were saved form data product produced by Beth
SurvAges1 <- read.csv(file.path(YTdir, "Data/NWFSCsurvey",
                               "FisheryIndices2017_Yellowtail_Final_SexedLgthWtAge.csv"),
                     skip=8)
SurvAges2 <- read.csv(file.path(YTdir, "Data/NWFSCsurvey",
                               "FisheryIndices2017_Yellowtail_Final_SexedLgthWtAge2016.csv"),
                     skip=8)
SurvAges <- rbind(SurvAges1, SurvAges2)
SurvAges$Survey.Year <- as.numeric(substring(SurvAges$PROJECT_CYCLE,7))
SurvAges$area <- ifelse(SurvAges$HAUL_LATITUDE_DD > 40+10/60, "North", "South")
table(SurvAges$area)
## North South 
##  6064   420 
  
# get ages from triennial survey
load(file.path(tridir,
               "AK.Surveys.Bio.yellowtail.22.Mar.2017.dmp"))
tri.ages <- AK.Surveys.Bio.yellowtail.22.Mar.2017$Ages
tri.ages$area <- ifelse(tri.ages$START_LATITUDE > 40+10/60, "North", "South")
table(tri.ages$area)
## North South 
##  9020   735 

# get ages from Hook & Line survey
HLbio <- read.csv(skip=4, file=file.path(HLdir,
                  "YellowtailRFDataSummaryAndCharts2004-2016 for Ian T_with ages_Bio.csv"))

# compile data from all sources
WLdata <- rbind(data.frame(weight_kg = SurvAges$WEIGHT_KG,
                           length_cm = SurvAges$LENGTH_CM,
                           sex       = SurvAges$SEX,
                           area      = SurvAges$area,
                           year      = SurvAges$Survey.Year,
                           timing    = c("early","late")[SurvAges$SURVEY_PASS],
                           source    = "NWFSCcombo_survey"),
                data.frame(weight_kg = tri.ages$INDV_WGHT_G/1000,
                           length_cm = tri.ages$LENGTH/10,
                           sex       = c("m","f")[tri.ages$SEX],
                           area      = tri.ages$area,
                           year      = tri.ages$YEAR,
                           timing    = ifelse(tri.ages$MONTH=='September',
                               'early', 'late'), # survey is June - Sept only
                           source    = "triennial_survey"),
                data.frame(weight_kg = HLbio$Wt..kg.,
                           length_cm = HLbio$Fork.Length..cm.,
                           sex       = tolower(HLbio$Sex),
                           area      = "South",
                           year      = HLbio$Year,
                           timing    = 'late',
                           source    = "Hook-n-line_survey")
                )

summary(WLdata)
 ##  weight_kg       length_cm     sex         area            year     
 ## Min.   :0.010   Min.   : 7.00   f:8323   North:15084   Min.   :1977  
 ## 1st Qu.:0.915   1st Qu.:39.00   m:9167   South: 2531   1st Qu.:1986  
 ## Median :1.275   Median :44.00   u: 125                 Median :2001  
 ## Mean   :1.247   Mean   :42.45                          Mean   :1999  
 ## 3rd Qu.:1.580   3rd Qu.:47.00                          3rd Qu.:2010  
 ## Max.   :4.060   Max.   :60.00                          Max.   :2016  
 ## NA's   :4836    NA's   :37                                           
 ##   timing                     source    
 ## early: 7512   NWFSCcombo_survey :6484  
 ## late :10103   triennial_survey  :9755  
 ##               Hook-n-line_survey:1376  
 
# remove NA values
WLdata <- na.omit(WLdata)

# run linear model with lots of variables
WL_lm1 <- lm(log(weight_kg) ~ log(length_cm)+sex+area+source+year+timing, data=WLdata)

summary(WL_lm1)

## Call:
## lm(formula = log(weight_kg) ~ log(length_cm) + sex + area + source + 
##     year + timing, data = WLdata)

## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.76139 -0.04890  0.00312  0.05114  0.81339 

## Coefficients:
##                            Estimate Std. Error t value Pr(>|t|)    
## (Intercept)              -1.013e+01  3.138e-01 -32.295  < 2e-16 ***
## log(length_cm)            3.071e+00  4.641e-03 661.808  < 2e-16 ***
## sexm                      9.033e-03  1.464e-03   6.170 7.02e-10 ***
## sexu                      2.138e-02  8.767e-03   2.439 0.014758 *  
## areaSouth                 2.304e-02  3.051e-03   7.553 4.55e-14 ***
## sourcetriennial_survey   -1.053e-02  3.159e-03  -3.334 0.000859 ***
## sourceHook-n-line_survey  3.706e-02  3.714e-03   9.978  < 2e-16 ***
## year                     -6.148e-04  1.555e-04  -3.953 7.76e-05 ***
## timinglate                1.013e-02  1.752e-03   5.781 7.60e-09 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

## Residual standard error: 0.08002 on 12769 degrees of freedom
## Multiple R-squared:  0.978,	Adjusted R-squared:  0.978 
## F-statistic: 7.11e+04 on 8 and 12769 DF,  p-value: < 2.2e-16

### estimated coefficients are small so simplifying by removing
### unsexed fish, year, and source (confounded with area),
### but adding interaction terms
WLdata2 <- WLdata[WLdata$sex != 'u',] # exclude unsexed fish
WL_lm2 <- lm(log(weight_kg) ~ log(length_cm)+sex+area+timing, data=WLdata2)
WL_lm3 <- lm(log(weight_kg) ~ log(length_cm)*sex*area*timing, data=WLdata2)

# random order in which to plot the points
samp <- sample(1:nrow(WLdata))

# vector of colors by point
col.vec <- rep(rgb(0,1,0,0.05), nrow(WLdata)) # green for u
col.vec[WLdata$sex=="f"] <- rgb(1,0,0,.05) # red for f
col.vec[WLdata$sex=="m"] <- rgb(0,0,1,.05) # blue for m

# get model predictions
x.vec <- seq(1,60,0.2)
dummy.data <- expand.grid(length_cm=x.vec,
                          sex=c('f','m'),
                          area=c('North','South'),
                          timing=c('early','late'))
dummy.data$pred_weight_kg <- exp(predict(WL_lm3, newdata=dummy.data,
                                         interval='none', type='response'))

#empty plot
plot(0,
     xlim=c(0, 1.05*max(WLdata$length_cm)),
     ylim=c(0, 1.05*max(WLdata$weight_kg)),
     xaxs='i', yaxs='i')

# add points
points(WLdata$length_cm[samp], WLdata$weight_kg[samp], col=col.vec[samp], pch=16)


# add lines with predictions
for(sex in c('f','m')){
  for(area in c('North','South')){
    #for(area in c('North')){
    for(timing in c('early','late')){
      sub <- dummy.data$sex==sex & dummy.data$area==area & dummy.data$timing==timing
      lines(dummy.data$length_cm[sub], dummy.data$pred_weight_kg[sub],
            col=c(3,2,4)[which(c('u','f','m')==sex)],
            lwd=which(c('early','late')==timing),
            lty=which(c('North','South')==area))
    }
  }
}

# plot with simpler lines
plot(0,
     xlim=c(15, 1.05*max(WLdata$length_cm)),
     ylim=c(0, 3),
     xaxs='i', yaxs='i')

# add points
points(WLdata$length_cm[samp], WLdata$weight_kg[samp], col=col.vec[samp], pch=16)

WL_lm4 <- lm(log(weight_kg) ~ log(length_cm)*sex, data=WLdata2[WLdata2$area=="North",])
dummy.data$pred_weight_kg_N <- exp(predict(WL_lm4, newdata=dummy.data,
                                           interval='none', type='response'))
# add lines with predictions
for(sex in c('f','m')){
  sub <- dummy.data$sex==sex & dummy.data$area==area & dummy.data$timing==timing
  lines(dummy.data$length_cm[sub], dummy.data$pred_weight_kg_N[sub],
        col=c(2,4)[which(c('f','m')==sex)], lwd=2)
}


# easier to get coefficents from separate models
WL_lm <- lm(log(weight_kg) ~ log(length_cm),
            data=WLdata[WLdata2$area=="North",])

# confirm correct interpretation of coefficients
exp(WL_lm$coefficients[1])*50^WL_lm$coefficients[2]
## (Intercept) 
##     1.92558

# plot on a log scale
plot(0,
     xlim=log(c(10, 1.05*max(WLdata$length_cm))),
     ylim=log(c(0.05, 1.05*max(WLdata$weight_kg))),
     xaxs='i', yaxs='i')

# add points
points(log(WLdata$length_cm[samp]),
       log(WLdata$weight_kg[samp]), col=col.vec[samp], pch=16)


#### figure for assessment

png(filename="Figures/weight-length_fit.png",
    width=6.5, height=4, res=300, units='in')
par(mar=c(4,4,1,1))
# plot with simpler lines
plot(0, xlim=c(15, 60), ylim=c(0, 3),
     xaxs='i', yaxs='i', xlab='Length (cm)', ylab='Weight (kg)', las=1)
# add points
points(WLdata$length_cm[samp], WLdata$weight_kg[samp], col=col.vec[samp], pch=16)
lines(x.vec, exp(WL_lm$coefficients[1])*x.vec^WL_lm$coefficients[2], lwd=2)
lines(x.vec, (0.0214*x.vec^2.920)/1000, lwd=2, lty=3)
print(exp(WL_lm$coefficients[1]),digits=5)
print(WL_lm$coefficients[2],digits=5)
legend('topleft', lty=c(1,3), lwd=c(2,2), bty='n',
       legend=c("New estimate","1997 assessment"))
dev.off()

 ## 1.1843e-05 
 ## 3.0672 

