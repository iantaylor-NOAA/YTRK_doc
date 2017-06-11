### notes on running profiles and making associated plots
### for 2017 Yellowtail Rockfish assessment

stop("\n  This file should not be sourced!") # note to stop Ian from accidental sourcing

# define directory on a specific computer
if (system("hostname", intern=TRUE) %in% c("NWCLW04223033") ){
  YTdir <- "C:/SS/Yellowtail/Yellowtail2017"
  YTdir.mods <- file.path(YTdir, "Models")
  YTdir.profs <- file.path(YTdir.mods, "profiles")
  if(is.na(file.info(YTdir.profs)$isdir)){
    dir.create(YTdir.profs)
  }
}


# load model output into R
# read base model from each area

mod.S <- 'South/12_Blocked_selectivity'
mod.S <- 'South/12b_unblock'
dir.S <- file.path(YTdir.mods, mod.S)
out.S <- SS_output(dir.S)

mod.N <- 'North/14d_no_discards_comps'
mod.N <- 'North/14k_extra_var_hake'
dir.N <- file.path(YTdir.mods, mod.N)
out.N <- SS_output(dir.N)

# estimated log(R0) value
out.S$parameters["SR_LN(R0)","Value"]
## [1] 9.53632
out.N$parameters["SR_LN(R0)","Value"]
## [1] 9.83596

# fixed M value
out.S$parameters["NatM_p_1_Fem_GP_1","Value"]
## [1] 0.12

# fixed h value
out.S$parameters["SR_BH_steep","Value"]
## [1] 0.718

# vectors of log(R0) spanning estimates
# (going from high to low in case low value cause crashes)
logR0vec.S <- seq(10.0, 8.0, -.2)
logR0vec.N <- seq(11.0, 9.0, -.2)

# vectors of M
M.vec <- seq(0.08, 0.20, 0.01)

# vectors of steepness
h.vec <- c(0.5, 0.6, 0.718, 0.8, 0.9)

####################################################################################
# function to copy input files
####################################################################################
copy.SS.files <- function(target=NULL, source=NULL,
                          SSsource='c:/ss/SSv3.30.03.07_May19/ss.exe',
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
  file.copy(from=SSsource,
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

####################################################################################
# run profiles
####################################################################################

##################################################################################
# log(R0) profiles
dir.prof.R0.S <- "prof.R0.S.12b"
copy.SS.files(source=mod.S, target=dir.prof.R0.S,
              control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=file.path(YTdir.profs, dir.prof.R0.S),
           string="R0", profilevec=logR0vec.S, extras="-nohess -nox")

dir.prof.R0.N <- "prof.R0.N.14k"
copy.SS.files(source=mod.N, target=dir.prof.R0.N,
              control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=file.path(YTdir.profs, dir.prof.R0.N),
           string="R0", profilevec=logR0vec.N, extras="-nohess -nox")

##################################################################################
# mortality profiles
dir.prof.M.S <- "prof.M.S.11b"
copy.SS.files(source=mod.S, target=dir.prof.M.S,
              control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=file.path(YTdir.profs, dir.prof.M.S),
           string="NatM_p_1_Fem_GP_1", profilevec=M.vec, extras="-nohess -nox")

##################################################################################
# steepness profiles
dir.prof.h.S <- file.path(YTdir.mods, "profiles", "prof.h.S")
copy.SS.files(mod="S", target=dir.prof.h.S, control.for.profile=TRUE, overwrite=TRUE)
SS_profile(dir=dir.prof.h.S, string="steep",
           profilevec=h.vec, extras="-nohess -nox")

####################################################################################
### plotting profile results
####################################################################################

##################################################################################
# Mortality profile South
profilemodels <- SSgetoutput(dirvec=file.path(YTdir.profs, dir.prof.M.S),
                             keyvec=1:length(M.vec), getcovar=FALSE)
# summarize output
profilesummary <- SSsummarize(profilemodels)
# open PNG file (allows extra axis to be added)
png(file.path(YTdir.mods, "profiles/profile_Mortality.S.png"),
    width=6.5, height=5, res=300, units='in', pointsize=10)
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.001,
              sort.by.max.change = FALSE,
              plotdir=dir.prof.M.S,
              profile.string = "NatM_p_1_Fem_GP_1", # substring of profile parameter
              profile.label="Natural mortality (M)") # axis label
axis(1,at=0.053) # axis showing base model values (prior median)
dev.off() # close PNG file

SSplotComparisons(profilesummary, subplot=1, legendlabels=paste0("M=",M.vec),
                  png=TRUE, plotdir=file.path(YTdir.mods, "profiles"), models=1:4,
                  filenameprefix="profile_Mortality.S_")

##################################################################################
# R0 profile South
dir.prof.R0.S <- file.path(YTdir.profs, "prof.R0.S.12b")
profilemodels <- SSgetoutput(dirvec=dir.prof.R0.S,
                             keyvec=1:length(logR0vec.S), getcovar=FALSE)
profilemodels$MLE <- out.S
profilesummary <- SSsummarize(profilemodels)
# plot profile using summary created above
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.0001,
              sort.by.max.change = FALSE,
              models = 1:length(logR0vec.S), # exclude MLE
              #xlim=c(3.2,4.6),
              #ymax=200,
              plotdir=dir.prof.R0.S,
              print=TRUE,
              profile.string = "R0", # substring of profile parameter
              profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
file.copy(file.path(dir.prof.R0.S, 'profile_plot_likelihood.png'),
          file.path(dir.prof.R0.S, 'profile_logR0.S.12b.png'), overwrite=TRUE)
SSplotComparisons(profilesummary, legendlabels=logR0vec.S)

# Piner Plot showing influence of age comps by fleet
PinerPlot(profilesummary,           # summary object
          component="Age_like",
          main="Changes in age-composition likelihoods by fleet",
          minfraction = 0.0001,
          models=1:length(logR0vec.S),
          #xlim=c(3.2,4.6),
          #ymax=200,
          plotdir=dir.prof.R0.S,
          print=TRUE,
          profile.string = "R0", # substring of profile parameter
          profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
file.copy(file.path(dir.prof.R0.S, 'profile_plot_likelihood.png'),
          file.path(dir.prof.R0.S, 'profile_age-comp_logR0.S_12b.png'), overwrite=TRUE)

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
file.copy(file.path(dir.prof.R0.S, 'profile_plot_likelihood.png'),
          file.path(dir.prof.R0.S, 'profile_indices_logR0.S_12b.png'), overwrite=TRUE)




# R0 profile North
dir.prof.R0.N <- file.path(YTdir.profs, "prof.R0.N.14k")
profilemodels <- SSgetoutput(dirvec=dir.prof.R0.N,
                             keyvec=1:length(logR0vec.N), getcovar=FALSE)
profilemodels$MLE <- out.N
profilesummary <- SSsummarize(profilemodels)
# plot profile using summary created above
SSplotProfile(profilesummary,           # summary object
              minfraction = 0.0001,
              models = 1:length(logR0vec.N), # exclude MLE
              sort.by.max.change = FALSE,
              #xlim=c(3.2,4.6),
              #ymax=50,
              plotdir=dir.prof.R0.N,
              print=TRUE,
              profile.string = "R0", # substring of profile parameter
              profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
file.copy(file.path(dir.prof.R0.N, 'profile_plot_likelihood.png'),
          file.path(YTdir.profs, 'profile_logR0.N_14k.png'), overwrite=TRUE)

# Piner Plot showing influence of age comps by fleet
PinerPlot(profilesummary,           # summary object
          component="Age_like",
          main="Changes in age-composition likelihoods by fleet",
          minfraction = 0.0001,
          models=1:length(logR0vec.N),
          #xlim=c(3.2,4.6),
          #ymax=200,
          plotdir=dir.prof.R0.N,
          print=TRUE,
          profile.string = "R0", # substring of profile parameter
          profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
file.copy(file.path(dir.prof.R0.N, 'profile_plot_likelihood.png'),
          file.path(dir.prof.R0.N, '../profile_age-comp_logR0.N_14k.png'), overwrite=TRUE)

# Piner Plot showing influence of indices by fleet
PinerPlot(profilesummary,           # summary object
          component="Surv_like",
          main="Changes in index likelihoods by fleet",
          minfraction = 0.0001,
          models=1:length(logR0vec.N),
          #xlim=c(3.2,4.6),
          #ymax=200,
          plotdir=dir.prof.R0.N,
          print=TRUE,
          profile.string = "R0", # substring of profile parameter
          profile.label="Log of unfished equilibrium recruitment, log(R0)") # axis label
file.copy(file.path(dir.prof.R0.N, 'profile_plot_likelihood.png'),
          file.path(dir.prof.R0.N, '../profile_indices_logR0.N_14k.png'), overwrite=TRUE)
