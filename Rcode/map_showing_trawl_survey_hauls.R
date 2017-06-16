############################################################################
# map showing hauls in NWFSC survey with Yellowtail catch
graphics.off()
if (system("hostname", intern=TRUE) %in% c("NWCLW04223033") ){
  YTdir <- "C:/SS/Yellowtail/Yellowtail2017"
  setwd(file.path(YTdir, "YTRK_doc"))

  if(FALSE){ # don't reload data when sourcing this file
    # CSV file with EEZ created by Ian from KML file available from
    # http://www.nauticalcharts.noaa.gov/csdl/mbound.htm#data
    eez <- read.csv('txt_files/EEZ_lat_lon.csv')


    YTdir.NWFSC <- file.path(YTdir, "Data/NWFSCsurvey")
    # note: CSV file is worksheet from Beth's extraction that's been saved as
    #       separate file
    # note: files are prior to June 5 revision but that change didn't impact this sheet
    Surv.Hauls1 <- read.csv(file.path(YTdir.NWFSC, 
                                      "FisheryIndices2017_Yellowtail_Final_HaulCatchWtEffort.csv"),
                            skip=8)
    Surv.Hauls2 <- read.csv(file.path(YTdir.NWFSC, 
                                      "FisheryIndices2017_Yellowtail_Final_HaulCatchWtEffort2016.csv"),
                            skip=8)
    Surv.Hauls <- rbind(Surv.Hauls1, Surv.Hauls2)
    # info on Hook & Line survey sites and Yellowtail catch
    HLsites <- read.csv('c:/data/Hook-n-line/200 Fixed Sites_PostSurvey 2015.csv')
    HLinfo <- read.csv(skip=4, file=file.path(HLdir,
                                   "YellowtailRFDataSummaryAndCharts2004-2016 for Ian T_with ages_Dates.csv"))
    HLsites$YTcount <- 0.0
    for(isite in 1:nrow(HLsites)){
      site <- HLsites$name[isite]
      HLsites$YTcount[isite] <- sum(HLinfo$Site==site)
    }
  }
}

# load packages
require(maps)
require(mapdata)

# open PNGfile
png('Figures/survey_hauls_map.png',
    width=8, height=6.5, res=350, units='in')
layout(mat=t(c(1,2)), widths=c(1,1.9))
for(iarea in 1:2){
  par(mar=c(3,5,.1,.1))
  if(iarea==1){
    xlim <- c(-126, -122)
    ylim <- c(40, 49)
  }else{
    xlim <- c(-125.5, -117)
    ylim <- c(31.7, 40.7)
  }    
  # map of Northern area only
  map('worldHires', regions=c("Canada","Mexico"),
      xlim=xlim, ylim=ylim, xaxs='i', yaxs='i',
      col='grey', fill=TRUE, interior=TRUE, lwd=1)
  lines(eez$lon, eez$lat, lty=3)
  # horizontal line at 40-10
  abline(h=c(40+10/60), lty=3)
  text(-127, 40, "40°10'", pos=3)
  # map with US states
  map('state', regions=c("Wash","Oreg","Calif","Idaho",
                   "Montana","Nevada","Arizona","Utah"),
      add=TRUE,
      col='grey', fill=TRUE, interior=TRUE, lwd=1)
  axis(2, at=seq(30,50,2), lab=paste0(seq(30,50,2), "°N"), las=3)
  axis(1, at=seq(-130,-114,2), lab=paste0(abs(seq(-130,-114,2)), "°W"))
  #map.axes()

  text(-123, 46.8, "WA")
  text(-123, 44, "OR")
  text(-123, 41, "CA")
  text(-120, 37, "CA")
  # empty hauls
  points(Surv.Hauls$BEST_LON_DD, Surv.Hauls$BEST_LAT_DD, pch=".", col=rgb(1,0,0,.4))
  # positive hauls
  points(Surv.Hauls$BEST_LON_DD, Surv.Hauls$BEST_LAT_DD, pch=16,
         cex=0.15*sqrt(Surv.Hauls$HAUL_WT_KG/Surv.Hauls$AREA_SWEPT_HA), col=rgb(0,0,1,.3))
  # Hook & Line catch
  if(iarea==2){
    # empty Hook & Line sites
    points(HLsites$lon, HLsites$lat, cex=.7, pch=3, col=rgb(.7,.2,1,.3))
    # positive Hook & Line sites
    points(HLsites$lon, HLsites$lat, cex=0.2*sqrt(HLsites$YTcount), pch=16,
           col=rgb(0,.5,0,.3))

    # legend
    legend('topright', pch=c(16,16,16,16,16,3),
           col=c(rep(rgb(0,0,1,.3), 2),
               rgb(1,0,0,.8),
               rep(rgb(0,.5,0,.3), 2),
               rgb(.7,.2,1,.7)),
           pt.cex=c(.15*sqrt(1000), .15*sqrt(100), .3, .2*sqrt(200), .2*sqrt(10), .7),
           legend=c("Trawl: 1000 kg/ha","Trawl: 100 kg/ha", "Trawl: no catch",
               "Hook & Line: 200 fish/site","Hook & Line: 20 fish/site",
               "Hook & Line: no catch"))
               
  }
    
  box()
} # end loop over area = 1 or 2
dev.off()

