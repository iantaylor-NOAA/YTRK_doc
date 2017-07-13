### notes on running profiles and making associated plots
### for 2017 Yellowtail Rockfish assessment
###
### NOTE: this file for Northern model only, separate file for Southern

#stop("\n  This file should not be sourced!") # note to stop Ian from accidental sourcing

# define directory on a specific computer
if (system("hostname", intern=TRUE) %in% c("NWCLW04223033","NWCDW04008137") ){
  YTdir <- "C:/SS/Yellowtail/Yellowtail2017"
  YTdir.mods <- file.path(YTdir, "Models")
  YTdir.profs <- file.path(YTdir.mods, "profiles")
  if(is.na(file.info(YTdir.profs)$isdir)){
    dir.create(YTdir.profs)
  }
  # example sourcing this file
  # source("c:/SS/Yellowtail/Yellowtail2017/YTRK_doc/Rcode/miscellaneous/Yellowtail_profile_notes.R")
}

require(r4ss)

# load model output into R
# read base model from each area
mod.N <- 'North/20_tuned'
mod.N <- 'North/STAR_2_NORTH'
dir.N <- file.path(YTdir.mods, mod.N)
out.N <- SS_output(dir.N)


# estimated log(R0) value
out.N$parameters["SR_LN(R0)","Value"]
## [1] 10.8322

# estimated M value
out.N$parameters["NatM_p_1_Fem_GP_1","Value"]
## [1] 0.173974

# fixed h value
out.N$parameters["SR_BH_steep","Value"]
## [1] 0.718

# vectors of log(R0) spanning estimates
# (going from high to low in case low value cause crashes)
logR0vec.N <- seq(11.4, 9.0, -.2)

### vectors below shared across models
# vectors of M
M.vec <- seq(0.10, 0.24, 0.02)

# vector of offsets for male mortality from equal to females
# down to about 75% of female M: exp(-0.3) ~ 0.74.
M2.vec <- seq(0, -0.3, -0.05) 

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
dir.prof.R0.N <- "prof.R0.N.STAR2"
copy.SS.files(source=mod.N, target=dir.prof.R0.N,
              control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=file.path(YTdir.profs, dir.prof.R0.N),
           string="R0", profilevec=logR0vec.N, extras="-nohess -nox")

##################################################################################
# mortality profiles
dir.prof.M.N <- "prof.M.N.STAR2"
copy.SS.files(source=mod.N, target=dir.prof.M.N,
              control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=file.path(YTdir.profs, dir.prof.M.N),
           string="NatM_p_1_Fem_GP_1", profilevec=M.vec, extras="-nohess -nox")

# M offset profile
dir.prof.M2.N <- "prof.M2.N.STAR2"
copy.SS.files(source=mod.N, target=dir.prof.M2.N,
              control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=file.path(YTdir.profs, dir.prof.M2.N),
           string="NatM_p_1_Mal_GP_1", profilevec=M2.vec, extras="-nohess -nox")

##################################################################################
# steepness profiles
dir.prof.h.N <- "prof.h.N.STAR2"
copy.SS.files(source=mod.N, target=dir.prof.h.N,
              control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=file.path(YTdir.profs, dir.prof.h.N),
           string="steep", profilevec=h.vec, extras="-nohess -nox")





####################################################################################
### plotting profile results
####################################################################################

# R0 profile North
dir.prof.R0.N <- file.path(YTdir.profs, "prof.R0.N.STAR2")
profilemodels <- SSgetoutput(dirvec=dir.prof.R0.N,
                             keyvec=1:length(logR0vec.N), getcovar=FALSE)
profilemodels$MLE <- out.N
profilesummary <- SSsummarize(profilemodels)


# plot profile using summary created above
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.0001,
              #models = 1:length(logR0vec.N), # optionally exclude MLE
              sort.by.max.change = FALSE,
              #xlim=c(3.2,4.6),
              ymax=25, # modify as required to get reasonable scale to see differences
              plotdir=dir.prof.R0.N,
              print=TRUE,
              profile.string = "R0", # substring of profile parameter
              profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
# copy plot with generic name to main folder with more specific name
file.copy(file.path(dir.prof.R0.N, 'profile_plot_likelihood.png'),
          file.path(YTdir.profs, 'profile_logR0.N.png'), overwrite=TRUE)

# Piner Plot showing influence of age comps by fleet
PinerPlot(profilesummary,           # summary object
          component="Age_like",
          main="Changes in age-composition likelihoods by fleet",
          minfraction = 0.0001,
          #models=1:length(logR0vec.N),
          #xlim=c(3.2,4.6),
          ymax=8,
          plotdir=dir.prof.R0.N,
          print=TRUE,
          profile.string = "R0", # substring of profile parameter
          profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
# copy plot with generic name to main folder with more specific name
file.copy(file.path(dir.prof.R0.N, 'profile_plot_likelihood.png'),
          file.path(dir.prof.R0.N, '../profile_age-comp_logR0.N.png'), overwrite=TRUE)

# Piner Plot showing influence of indices by fleet
PinerPlot(profilesummary,           # summary object
          component="Surv_like",
          main="Changes in index likelihoods by fleet",
          minfraction = 0.0001,
          #models=1:length(logR0vec.N),
          #xlim=c(3.2,4.6),
          #ymax=200,
          plotdir=dir.prof.R0.N,
          print=TRUE,
          profile.string = "R0", # substring of profile parameter
          profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
# copy plot with generic name to main folder with more specific name
file.copy(file.path(dir.prof.R0.N, 'profile_plot_likelihood.png'),
          file.path(dir.prof.R0.N, '../profile_indices_logR0.N.png'), overwrite=TRUE)

SSplotComparisons(profilesummary, subplot=1,
                  legendlabels=c(paste0("log(R0)=",logR0vec.N),"Base Model"),
                  png=TRUE, plotdir=file.path(YTdir.mods, "profiles"),
                  filenameprefix="profile_R0.N_", legendloc="bottomleft")

##################################################################################
# Mortality profile North
dir.prof.M.N <- file.path(YTdir.profs, "prof.M.N.STAR2")
profilemodels <- SSgetoutput(dirvec=dir.prof.M.N,
                             keyvec=1:length(M.vec), getcovar=FALSE)
# add MLE to set of models being plotted
profilemodels$MLE <- out.N

# summarize output
good <- c(1:5,8) # which models converged 9 is the MLE
profilesummary <- SSsummarize(profilemodels[c(good, 9)])
# make plot
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.001,
              print=TRUE,
              ymax=30,
              sort.by.max.change = FALSE,
              plotdir=dir.prof.M.N,
              profile.string = "NatM_p_1_Fem_GP_1", # substring of profile parameter
              profile.label="Female natural mortality (M)") # axis label
# copy plot with generic name to main folder with more specific name
file.copy(file.path(dir.prof.M.N, 'profile_plot_likelihood.png'),
          file.path(dir.prof.M.N, '../profile_M.N.png'), overwrite=TRUE)

# compare spawning biomass time series
SSplotComparisons(profilesummary, subplot=1,
                  legendlabels=c(paste0("M=",M.vec[good]),"Base Model (M ~ 0.145)"),
                  png=TRUE, plotdir=file.path(YTdir.mods, "profiles"),
                  filenameprefix="profile_M.N_", legendloc="bottomleft")


##################################################################################
# Mortality offset for Males profile North
dir.prof.M2.N <- file.path(YTdir.profs, "prof.M2.N.STAR2")
profilemodels <- SSgetoutput(dirvec=dir.prof.M2.N,
                             keyvec=1:length(M2.vec), getcovar=FALSE)
# add MLE to set of models being plotted
profilemodels$MLE <- out.N

# summarize output
profilesummary <- SSsummarize(profilemodels)
# make plot
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.001,
              print=TRUE,
              sort.by.max.change = FALSE,
              plotdir=dir.prof.M2.N,
              profile.string = "NatM_p_1_Mal_GP_1", # substring of profile parameter
              profile.label="Natural mortality offset for males") # axis label
# copy plot with generic name to main folder with more specific name
file.copy(file.path(dir.prof.M2.N, 'profile_plot_likelihood.png'),
          file.path(dir.prof.M2.N, '../profile_M2.N.png'), overwrite=TRUE)

# compare spawning biomass time series
SSplotComparisons(profilesummary, subplot=1,
                  legendlabels=c(paste0("male offset=",M2.vec),"Base Model (offset ~ -0.137)"),
                  png=TRUE, plotdir=file.path(YTdir.mods, "profiles"),
                  filenameprefix="profile_M2.N_", legendloc="bottomleft")

##################################################################################
# Steepness profile North
dir.prof.h.N <- file.path(YTdir.profs, "prof.h.N.STAR2")
profilemodels <- SSgetoutput(dirvec=dir.prof.h.N,
                             keyvec=1:length(h.vec), getcovar=FALSE)
# summarize output
profilesummary <- SSsummarize(profilemodels)
# make plot
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.001,
              print=TRUE,
              sort.by.max.change = FALSE,
              plotdir=dir.prof.h.N,
              profile.string = "steep", # substring of profile parameter
              profile.label="Stock-recruit steepness (h)") # axis label
# copy plot with generic name to main folder with more specific name
file.copy(file.path(dir.prof.h.N, 'profile_plot_likelihood.png'),
          file.path(dir.prof.h.N, '../profile_h.N.png'), overwrite=TRUE)
# compare spawning biomass time series
labels <- paste0("h=",h.vec)
labels[h.vec==0.718] <- paste(labels[h.vec==0.718], "(Base Model)")
SSplotComparisons(profilesummary, subplot=1,
                  legendlabels=labels,
                  png=TRUE, plotdir=file.path(YTdir.mods, "profiles"),
                  filenameprefix="profile_steep.N_", legendloc="bottomleft")

} # end if(FALSE) section that doesn't get sourced
