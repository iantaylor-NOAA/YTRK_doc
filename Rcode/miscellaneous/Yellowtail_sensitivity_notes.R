### notes on running profiles and making associated plots
### for 2017 Yellowtail Rockfish assessment
###
### NOTE: this file mostly just for the Northern model

# define directory on a specific computer
if (system("hostname", intern=TRUE) %in% c("NWCLW04223033") ){
  YTdir <- "C:/SS/Yellowtail/Yellowtail2017"
  YTdir.mods <- file.path(YTdir, "Models")
  YTdir.sens.N <- file.path(YTdir.mods, "North_sens_20")
  YTdir.sens.S <- file.path(YTdir.mods, "South_sens_18")
}

require(r4ss)

# load model output into R
# read base model from each area
mod.N <- 'North/20_tuned'
dir.N <- file.path(YTdir.mods, mod.N)
out.N <- SS_output(dir.N)

mod.S <- 'South/18_New_South_Base'
dir.S <- file.path(YTdir.mods, mod.S)
out.S <- SS_output(dir.S)


####################################################################################
# function to copy input files
####################################################################################
copy.SS.files <- function(target=NULL, source=NULL, mod="N",
                          control.for.profile=FALSE, overwrite=FALSE){
  start <- SS_readstarter(file.path(YTdir.mods, source, "starter.ss"))
  YTdir.sens <- get(paste0("YTdir.sens.",mod))
  
  dir.create(file.path(YTdir.sens, target))
  file.copy(from=file.path(YTdir.mods, source, "forecast.ss"),
            to = file.path(YTdir.sens, target, "forecast.ss"), overwrite=overwrite)
  file.copy(from=file.path(YTdir.mods, source, start$ctlfile),
            to = file.path(YTdir.sens, target, start$ctlfile), overwrite=overwrite)
  file.copy(from=file.path(YTdir.mods, source, 'control.ss_new'),
            to = file.path(YTdir.sens, target, 'control.ss_new'), overwrite=overwrite)
  file.copy(from=file.path(YTdir.mods, source, start$datfile),
            to = file.path(YTdir.sens, target, start$datfile), overwrite=overwrite)
  ## file.copy(from=SSsource,
  ##          to = file.path(YTdir.sens, target, "ss.exe"), overwrite=overwrite)
  file.copy(from=file.path(YTdir.mods, source, "ss.exe"),
            to = file.path(YTdir.sens, target, "ss.exe"), overwrite=overwrite)
  if(control.for.profile){
    start$ctlfile <- "control_modified.ss"
    # make sure the prior likelihood is calculated
    # for non-estimated quantities
    start$prior_like <- 1
    # write modified starter file
    SS_writestarter(start, dir=file.path(YTdir.sens, target), overwrite=overwrite)
  }else{
    file.copy(from=file.path(YTdir.mods, source, "starter.ss"),
              to=file.path(YTdir.sens, target, "starter.ss"), overwrite=overwrite)
  }
}

if(FALSE){ # don't run all the stuff below if sourcing the file

  # source this file
  source('c:/SS/Yellowtail/Yellowtail2017/YTRK_doc/Rcode/miscellaneous/Yellowtail_sensitivity_notes.R')

  ####################################################################################
  # run sensitivities
  ####################################################################################

  ##################################################################################
  # McAllister-Ianelli tuning NORTH
  dir.sens.MItune.N <- "sens.MItune.N"
  copy.SS.files(source=mod.N, target=dir.sens.MItune.N,
                mod="N", overwrite=TRUE)
  varadjust <- SS_tune_comps(out.N, option="MI")
  SS_varadjust(dir = file.path(YTdir.sens.N, "sens.MItune.N"),
               newtable = varadjust,
               ctlfile=out.N$Control_File, newctlfile=out.N$Control_File,
               overwrite=TRUE)

  # read output
  out.sens.MItune.N <- SS_output(file.path(YTdir.sens.N, "sens.MItune.N"))

  ##################################################################################
  # Alternative M assumptions NORTH
  out.sens.M_age64_est.N <- SS_output(file.path(YTdir.sens.N, "sens.M_age64_est"))
  out.sens.M_age64_fix.N <- SS_output(file.path(YTdir.sens.N, "sens.M_age64_fix"))

  ##################################################################################
  # Eliminating indices using lambdas

  out.sens.no_fishery_indices.N <- SS_output(file.path(YTdir.sens.N, "sens.no_fishery_indices"))
  out.sens.no_hake_indices.N <- SS_output(file.path(YTdir.sens.N, "sens.no_hake_index"))
  out.sens.no_logbook_indices.N <- SS_output(file.path(YTdir.sens.N, "sens.no_logbook_index"))

  
  ##################################################################################
  # Comparing Northern sensitivities

  summary.sens.N <-
    SSsummarize(list(out.N,
                     out.sens.MItune.N,
                     out.sens.M_age64_est.N,
                     out.sens.M_age64_fix.N,
                     out.sens.no_logbook_indices.N,
                     out.sens.no_hake_indices.N,
                     out.sens.no_fishery_indices.N))
  namelist <- c("Northern Base Model",
                "McAllister-Ianelli weights",
                "M prior Age64",
                "M fixed Age64",
                "No commercial index",
                "No hake bycatch index",
                "No commercial or hake indices")
  SSplotComparisons(summary.sens.N,
                    legendlabels=namelist,
                    densitynames=c("SPB_Virgin", "R0",
                        "NatM_p_1_Fem_GP_1"),
                    indexfleets=6,
                    indexUncertainty=TRUE,
                    plot=FALSE, print=TRUE,
                    plotdir=YTdir.sens.N)

  thingnames = c("Recr_Virgin", "R0", "NatM",
      "SPB_Virg", "SPB_2017",
      "Bratio_2017", "SPRratio_2016", "TotYield_MSY")
 
  sens.N.table <-
    SStableComparisons(summary.sens.N,
                       modelnames=namelist,
                       names=thingnames,
                       csv=TRUE,
                       csvdir = YTdir.sens.N,
                       csvfile = "comparison_table_sens.N.csv"
                       )

  
  ##################################################################################
  # McAllister-Ianelli tuning SOUTH
  dir.sens.MItune.S <- "sens.MItune.S"
  copy.SS.files(source=mod.S, target=dir.sens.MItune.S,
                mod="S", overwrite=TRUE)
  varadjust <- SS_tune_comps(out.S, option="MI")
  SS_varadjust(dir = file.path(YTdir.sens.S, "sens.MItune.S"),
               newtable = varadjust,
               ctlfile=out.S$Control_File, newctlfile=out.S$Control_File,
               overwrite=TRUE)
  setwd(file.path(YTdir.sens.S, "sens.MItune.S"))

  out.sens.MItune.S <- SS_output(file.path(YTdir.sens.S, "sens.MItune.S"))
  SSplotComparisons(SSsummarize(list(out.S, out.sens.MItune.S)))

  ##################################################################################
  # Fixed catchability for the South
  out.sens.NWFSCcombo.S <- SS_output(file.path(YTdir.sens.S, "sens.NWFSCcombo"))

  ##################################################################################
  # No recdevs after 2006
  out.recdevs2006 <- SS_output(file.path(YTdir.sens.S, "sens.recdevs_end_2006"))


  
  ##################################################################################
  # Running jitter for the North
  dir.N.jit <- 'C:/SS/Yellowtail/Yellowtail2017/Models/North/20_Base_Model_Jitter'
  jit.N <- SS_RunJitter(dir.N.jit, Njitter=100)

  dir.N.jit <- 'C:/SS/Yellowtail/Yellowtail2017/Models/North/20_tuned_jitter'
  jit.N <- SS_RunJitter(dir.N.jit, Njitter=100)
  
} # end if(FALSE) section that doesn't get sourced
