### notes on running profiles and making associated plots
### for 2017 Yellowtail Rockfish assessment
###
### NOTE: this file for Southern model only, separate file for Northern

#stop("\n  This file should not be sourced!") # note to stop Ian from accidental sourcing

# define directory on a specific computer
if (system("hostname", intern=TRUE) %in% c("NWCLW04223033") ){
  YTdir <- "C:/SS/Yellowtail/Yellowtail2017"
  YTdir.mods <- file.path(YTdir, "Models")
  YTdir.profs <- file.path(YTdir.mods, "profiles")
  if(is.na(file.info(YTdir.profs)$isdir)){
    dir.create(YTdir.profs)
  }
  # example sourcing this file
  # source("c:/SS/Yellowtail/Yellowtail2017/YTRK_doc/Rcode/miscellaneous/Yellowtail_profiles_South.R")
}

require(r4ss)

# load model output into R
# read base model from each area
mod.S <- 'South/18_New_South_Base'
dir.S <- file.path(YTdir.mods, mod.S)
if(!exists('out.S')){
  out.S <- SS_output(dir.S)
}

# estimated log(R0) value
out.S$parameters["SR_LN(R0)","Value"]
## [1] 10.4209

# fixed M values
out.S$parameters["NatM_p_1_Fem_GP_1","Value"]
## [1] 0.18
out.S$parameters["NatM_p_1_Mal_GP_1","Value"]
## [1] -0.2876
# confirm that product of female M and exponential of male offset is ~ 0.135
out.S$parameters["NatM_p_1_Fem_GP_1","Value"]*
  exp(out.S$parameters["NatM_p_1_Mal_GP_1","Value"])
## [1] 0.1350111

# fixed h value
out.S$parameters["SR_BH_steep","Value"]
## [1] 0.718


# vectors of log(R0) spanning estimates
# (going from high to low in case low value cause crashes)
logR0vec.S <- seq(11.0, 8.6, -.2)

### vectors below shared across models
# vectors of M
M.vec <- seq(0.10, 0.24, 0.02)

# vector of offsets for male mortality from equal to females
# down to about 75% of female M: exp(-0.3) ~ 0.74.
M2.vec <- seq(0, -0.4, -0.05) 

# vectors of steepness
h.vec <- c(0.5, 0.6, 0.718, 0.8, 0.9)

####################################################################################
# function to copy input files
####################################################################################
copy.SS.files <- function(target=NULL, source=NULL,
                          #SSsource='c:/ss/SSv3.30.03.07_May19/ss.exe',
                          control.for.profile=FALSE, overwrite=FALSE){
  start <- SS_readstarter(file.path(YTdir.mods, source, "starter.ss"))
  dir.create(file.path(YTdir.profs, target))
  file.copy(from=file.path(YTdir.mods, source, "forecast.ss"),
            to = file.path(YTdir.profs, target, "forecast.ss"), overwrite=overwrite)
  file.copy(from=file.path(YTdir.mods, source, start$ctlfile),
            to = file.path(YTdir.profs, target, start$ctlfile), overwrite=overwrite)
  file.copy(from=file.path(YTdir.mods, source, 'control.ss_new'),
            to = file.path(YTdir.profs, target, 'control.ss_new'), overwrite=overwrite)
  file.copy(from=file.path(YTdir.mods, source, start$datfile),
            to = file.path(YTdir.profs, target, start$datfile), overwrite=overwrite)
  ## file.copy(from=SSsource,
  ##          to = file.path(YTdir.profs, target, "ss.exe"), overwrite=overwrite)
  file.copy(from=file.path(YTdir.mods, source, "ss.exe"),
            to = file.path(YTdir.profs, target, "ss.exe"), overwrite=overwrite)
  if(control.for.profile){
    start$ctlfile <- "control_modified.ss"
    # make sure the prior likelihood is calculated
    # for non-estimated quantities
    start$prior_like <- 1
    # write modified starter file
    SS_writestarter(start, dir=file.path(YTdir.profs, target), overwrite=overwrite)
  }else{
    file.copy(from=file.path(YTdir.profs, source, "starter.ss"),
              to=file.path(YTdir.profs, target, "starter.ss"), overwrite=overwrite)
  }
}

if(FALSE){ # don't run all the stuff below if sourcing the file

####################################################################################
# run profiles
####################################################################################

##################################################################################
# log(R0) profiles
dir.prof.R0.S <- "prof.R0.S.18"
copy.SS.files(source=mod.S, target=dir.prof.R0.S,
              control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=file.path(YTdir.profs, dir.prof.R0.S),
           string="R0", profilevec=logR0vec.S, extras="-nohess -nox")

##################################################################################
# mortality profiles
dir.prof.M.S <- "prof.M.S.18"
copy.SS.files(source=mod.S, target=dir.prof.M.S,
              control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=file.path(YTdir.profs, dir.prof.M.S),
           string="NatM_p_1_Fem_GP_1", profilevec=M.vec, extras="-nohess -nox")

# M offset profile
dir.prof.M2.S <- "prof.M2.S.18"
copy.SS.files(source=mod.S, target=dir.prof.M2.S,
              control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=file.path(YTdir.profs, dir.prof.M2.S),
           string="NatM_p_1_Mal_GP_1", profilevec=M2.vec, extras="-nohess -nox")

##################################################################################
# steepness profiles
dir.prof.h.S <- "prof.h.S.18"
copy.SS.files(source=mod.S, target=dir.prof.h.S,
              control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=file.path(YTdir.profs, dir.prof.h.S),
           string="steep", profilevec=h.vec, extras="-nohess -nox")





####################################################################################
### plotting profile results
####################################################################################

# R0 profile
dir.prof.R0.S <- file.path(YTdir.profs, "prof.R0.S.18")
profilemodels <- SSgetoutput(dirvec=dir.prof.R0.S,
                             keyvec=1:length(logR0vec.S), getcovar=FALSE)
profilemodels$MLE <- out.S
profilesummary <- SSsummarize(profilemodels)


# plot profile using summary created above
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.0001,
              #models = 1:length(logR0vec.S), # optionally exclude MLE
              sort.by.max.change = FALSE,
              #xlim=c(3.2,4.6),
              ymax=10, # modify as required to get reasonable scale to see differences
              plotdir=dir.prof.R0.S,
              print=TRUE,
              profile.string = "R0", # substring of profile parameter
              profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
# copy plot with generic name to main folder with more specific name
file.copy(file.path(dir.prof.R0.S, 'profile_plot_likelihood.png'),
          file.path(YTdir.profs, 'profile_logR0.S.png'), overwrite=TRUE)

# Piner Plot showing influence of age comps by fleet
PinerPlot(profilesummary,           # summary object
          component="Age_like",
          main="Changes in age-composition likelihoods by fleet",
          minfraction = 0.0001,
          #models=1:length(logR0vec.S),
          #xlim=c(3.2,4.6),
          #ymax=8,
          plotdir=dir.prof.R0.S,
          print=TRUE,
          profile.string = "R0", # substring of profile parameter
          profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
# copy plot with generic name to main folder with more specific name
file.copy(file.path(dir.prof.R0.S, 'profile_plot_likelihood.png'),
          file.path(dir.prof.R0.S, '../profile_age-comp_logR0.S.png'), overwrite=TRUE)

# Piner Plot showing influence of indices by fleet
PinerPlot(profilesummary,           # summary object
          component="Surv_like",
          main="Changes in index likelihoods by fleet",
          minfraction = 0.0001,
          models=1:length(logR0vec.S),
          #xlim=c(3.2,4.6),
          #ymax=200,
          plotdir=dir.prof.R0.S,
          print=TRUE,
          profile.string = "R0", # substring of profile parameter
          profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
# copy plot with generic name to main folder with more specific name
file.copy(file.path(dir.prof.R0.S, 'profile_plot_likelihood.png'),
          file.path(dir.prof.R0.S, '../profile_indices_logR0.S.png'), overwrite=TRUE)

SSplotComparisons(profilesummary, subplot=1,
                  legendlabels=c(paste0("log(R0)=",logR0vec.S),"Base Model"),
                  png=TRUE, plotdir=file.path(YTdir.mods, "profiles"),
                  filenameprefix="profile_R0.S_", legendloc="bottomleft")

##################################################################################
# Mortality profile
dir.prof.M.S <- file.path(YTdir.profs, "prof.M.S.18")
profilemodels <- SSgetoutput(dirvec=dir.prof.M.S,
                             keyvec=1:length(M.vec), getcovar=FALSE)
# add MLE to set of models being plotted
profilemodels$MLE <- out.S

# summarize output
good <- c(1,3:8) # which models converged, 9 is the MLE
profilesummary <- SSsummarize(profilemodels[c(good, 9)])
# make plot
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.001,
              print=TRUE,
              sort.by.max.change = FALSE,
              plotdir=dir.prof.M.S,
              profile.string = "NatM_p_1_Fem_GP_1", # substring of profile parameter
              profile.label="Natural mortality (M)") # axis label
# copy plot with generic name to main folder with more specific name
file.copy(file.path(dir.prof.M.S, 'profile_plot_likelihood.png'),
          file.path(dir.prof.M.S, '../profile_M.S.png'), overwrite=TRUE)

# compare spawning biomass time series
SSplotComparisons(profilesummary, subplot=c(1,3),
                  legendlabels=c(paste0("M=",M.vec[good]),"Base Model"),
                  png=TRUE, plotdir=file.path(YTdir.mods, "profiles"),
                  filenameprefix="profile_M.S_", legendloc="topleft")


##################################################################################
# Mortality offset for Males profile
dir.prof.M2.S <- file.path(YTdir.profs, "prof.M2.S.18")
profilemodels <- SSgetoutput(dirvec=dir.prof.M2.S,
                             keyvec=1:length(M2.vec), getcovar=FALSE)
# add MLE to set of models being plotted
profilemodels$MLE <- out.S

# summarize output
profilesummary <- SSsummarize(profilemodels)
# make plot
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.001,
              print=TRUE,
              sort.by.max.change = FALSE,
              plotdir=dir.prof.M2.S,
              profile.string = "NatM_p_1_Mal_GP_1", # substring of profile parameter
              profile.label="Natural mortality offset for males") # axis label
# copy plot with generic name to main folder with more specific name
file.copy(file.path(dir.prof.M2.S, 'profile_plot_likelihood.png'),
          file.path(dir.prof.M2.S, '../profile_M2.S.png'), overwrite=TRUE)

# compare spawning biomass time series
mods <- c(seq(1,7,2), 8) # subset of models
SSplotComparisons(profilesummary, subplot=c(1,3), models=mods,
                  legendlabels=c(paste0("male offset=",M2.vec),"Base Model")[mods],
                  png=TRUE, plotdir=file.path(YTdir.mods, "profiles"),
                  filenameprefix="profile_M2.S_", legendloc="bottomright")

##################################################################################
# Steepness profile 
dir.prof.h.S <- file.path(YTdir.profs, "prof.h.S.18")
profilemodels <- SSgetoutput(dirvec=dir.prof.h.S,
                             keyvec=1:length(h.vec), getcovar=FALSE)
# summarize output
profilesummary <- SSsummarize(profilemodels)
# make plot
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.001,
              print=TRUE,
              sort.by.max.change = FALSE,
              plotdir=dir.prof.h.S,
              profile.string = "steep", # substring of profile parameter
              profile.label="Stock-recruit steepness (h)") # axis label
# copy plot with generic name to main folder with more specific name
file.copy(file.path(dir.prof.h.S, 'profile_plot_likelihood.png'),
          file.path(dir.prof.h.S, '../profile_h.S.png'), overwrite=TRUE)
# compare spawning biomass time series
labels <- paste0("h=",h.vec)
labels[h.vec==0.718] <- paste(labels[h.vec==0.718], "(Base Model)")
SSplotComparisons(profilesummary, subplot=1,
                  legendlabels=labels,
                  png=TRUE, plotdir=file.path(YTdir.mods, "profiles"),
                  filenameprefix="profile_steep.S_", legendloc="bottomleft")

} # end if(FALSE) section that doesn't get sourced
