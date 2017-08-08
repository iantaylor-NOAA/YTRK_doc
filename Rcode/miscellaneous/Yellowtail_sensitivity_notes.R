### notes on running profiles and making associated plots
### for 2017 Yellowtail Rockfish assessment
###
### NOTE: this file mostly just for the Northern model

# define directory on a specific computer
if (system("hostname", intern=TRUE) %in% c("NWCLW04223033") ){
  YTdir <- "C:/SS/Yellowtail/Yellowtail2017"
  YTdir.mods <- file.path(YTdir, "Models")
  YTdir.sens.N <- file.path(YTdir.mods, "North_sens_Final")
  YTdir.sens.S <- file.path(YTdir.mods, "South_sens_21")
}

require(r4ss)

# load model output into R
# read base model from each area
mod.N <- 'North/STAR_2_NORTH'
dir.N <- file.path(YTdir.mods, mod.N)
out.N <- SS_output(dir.N)

mod.S <- 'South/21_newbase'
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

  ## out.sens.no_fishery_indices.N <- SS_output(file.path(YTdir.sens.N, "sens.no_fishery_indices"))
  ## out.sens.no_hake_indices.N <- SS_output(file.path(YTdir.sens.N, "sens.no_hake_index"))
  ## out.sens.no_logbook_indices.N <- SS_output(file.path(YTdir.sens.N, "sens.no_logbook_index"))
  out.sens.add_fishery_indices.N <- SS_output(file.path(YTdir.sens.N, "sens.N_add_both_comm_indices"))
  out.sens.add_hake_indices.N <- SS_output(file.path(YTdir.sens.N, "sens.N_add_hake_index"))
  out.sens.add_logbook_indices.N <- SS_output(file.path(YTdir.sens.N, "sens.N_add_logbook_index"))

  # alternative maturity ogives
  out.mat2.N <- SS_output(file.path(YTdir.sens.N, "sens.GundersonMaturity"))
  out.mat3.N <- SS_output(file.path(YTdir.sens.N, "sens.EcheverriaMaturity"))
  legend.mat <- c("Northern base model (50% maturity at 42.5cm)",
                  "Echeverria (1987) maturity (50% maturity at 36.4cm)",
                  "Gunderson (1980) maturity (50% at 45.0cm)")
  # plot summary biomass for alternative maturity curves
  png(file.path(YTdir.sens.N, 'compare_smry_bio_maturities.N.png'),
      width=6.5, height=5, res = 300, units = 'in')
  par(mar=c(4,4,1,1))
  cols <- c(4,2,3)
  yrs <- mod1$timeseries$Yr
  show <- yrs <= mod1$endyr+1
  y1 <- 1e-3*mod1$timeseries[["Bio_smry"]][show]
  y2 <- 1e-3*out.mat2.N$timeseries[["Bio_smry"]][show]
  y3 <- 1e-3*out.mat3.N$timeseries[["Bio_smry"]][show]
  yrs <- yrs[show]
  plot(0, xlim=range(yrs), ylim=c(0, 1.1*max(y1,y2)), yaxs='i',
       xlab="Year", ylab="Age 4+ biomass (x 1000 mt)", type='n', las=1)
  lines(yrs, y2, lwd=3, col=cols[2])
  lines(yrs, y3, lwd=3, col=cols[3])
  lines(yrs, y1, lwd=3, col=cols[1])
  legend('bottomleft', legend.mat, lwd=3, col=cols, bty='n')
  dev.off()

  # alternative maturity ogives SOUTH
  out.mat2.S <- SS_output(file.path(YTdir.sens.S, "sens.S.GundersonMaturity"))
  out.mat3.S <- SS_output(file.path(YTdir.sens.S, "sens.S.EcheverriaMaturity"))
  legend.mat <- c("Southern base model (50% maturity at 42.5cm)",
                  "Echeverria (1987) maturity (50% maturity at 36.4cm)",
                  "Gunderson (1980) maturity (50% at 45.0cm)")
  # plot summary biomass for alternative maturity curves
  png(file.path(YTdir.sens.S, 'compare_smry_bio_maturities.S.png'),
      width=6.5, height=5, res = 300, units = 'in')
  par(mar=c(4,4,1,1))
  cols <- c(4,2,3)
  yrs <- mod1$timeseries$Yr
  show <- yrs <= mod1$endyr+1
  y1 <- 1e-3*mod2$timeseries[["Bio_smry"]][show]
  y2 <- 1e-3*out.mat2.S$timeseries[["Bio_smry"]][show]
  y3 <- 1e-3*out.mat3.S$timeseries[["Bio_smry"]][show]
  yrs <- yrs[show]
  plot(0, xlim=range(yrs), ylim=c(0, 1.1*max(y1,y2)), yaxs='i',
       xlab="Year", ylab="Age 4+ biomass (x 1000 mt)", type='n', las=1)
  lines(yrs, y2, lwd=3, col=cols[2])
  lines(yrs, y3, lwd=3, col=cols[3])
  lines(yrs, y1, lwd=3, col=cols[1])
  legend('bottomleft', legend.mat, lwd=3, col=cols, bty='n')
  dev.off()

  
  ##################################################################################
  # early recdevs North
  sens.N.recdevs1869 <- SS_output(file.path(YTdir.sens.N,'sens.N.recdevs1869'))
  sens.N.recdevs1889 <- SS_output(file.path(YTdir.sens.N,'sens.N.recdevs1889'))
  SSplotComparisons(SSsummarize(list(mod1, sens.N.recdevs1889, sens.N.recdevs1869)), subplot=2,
                    legendlabels=c('Northern base model',
                        'Recruitment deviations start in 1889',
                        'Recruitment deviations start in 1869'),
                    )

  # early recdevs South
  sens.S.recdevs1869 <- SS_output(file.path(YTdir.sens.S,'sens.S.recdevs1869'))
  sens.S.recdevs1889 <- SS_output(file.path(YTdir.sens.S,'sens.S.recdevs1889'))
  SSplotComparisons(SSsummarize(list(out.S, sens.S.recdevs1889, sens.S.recdevs1869)),
                    subplot=c(2,4),
                    legendlabels=c('Southern base model',
                        'Recruitment deviations start in 1889',
                        'Recruitment deviations start in 1869'),
                    )


  ##################################################################################
  # early recdevs North
  out.N.20b_added_variance <- SS_output(file.path(YTdir.mods,'North/20b_added_variance'))
  out.N.20c_block_rec_selex <- SS_output(file.path(YTdir.mods,'North/20c_block_rec_selex'),
                                         covar=FALSE)

  
  ##################################################################################
  # Comparing Northern sensitivities

  summary.sens.N <-
    SSsummarize(list(out.N,
                     out.sens.MItune.N,
                     out.sens.M_age64_est.N,
                     out.sens.M_age64_fix.N,
                     out.sens.add_logbook_indices.N,
                     out.sens.add_hake_indices.N,
                     out.sens.add_fishery_indices.N))
  namelist <- c("Northern Base Model",
                "McAllister-Ianelli weights",
                "M prior Age64",
                "M fixed Age64",
                "Add commercial index",
                "Add hake bycatch index",
                "Add commercial and hake indices")
  SSplotComparisons(summary.sens.N,
                    legendloc='bottomleft', subplot=1:2, 
                    legendlabels=namelist,
                    densitynames=c("SPB_Virgin", "R0",
                        "NatM_p_1_Fem_GP_1"),
                    indexfleets=6,
                    indexUncertainty=TRUE,
                    plot=FALSE, print=TRUE,
                    plotdir=YTdir.sens.N)
# remake plots 1 and 2 with legend in lower left
  SSplotComparisons(summary.sens.N,
                    legendloc=c(0, 0.4), subplot=1:2, 
                    legendlabels=namelist,
                    densitynames=c("SPB_Virgin", "R0",
                        "NatM_p_1_Fem_GP_1"),
                    indexfleets=6,
                    indexUncertainty=TRUE,
                    plot=FALSE, print=TRUE,
                    plotdir=YTdir.sens.N)
# remake plots 3 and 4 with legend in specific spot
  SSplotComparisons(summary.sens.N,
                    legendloc=c(0, 0.75), subplot=3:4, 
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

  out.mat2.S <- SS_output(file.path(YTdir.sens.S, "sens.S.GundersonMaturity"))
  out.mat3.S <- SS_output(file.path(YTdir.sens.S, "sens.S.EcheverriaMaturity"))

  
  ##################################################################################
  # Running jitter for the North
  dir.N.jit <- 'C:/SS/Yellowtail/Yellowtail2017/Models/North/20_Base_Model_Jitter'
  jit.N <- SS_RunJitter(dir.N.jit, Njitter=100)

  dir.N.jit <- 'C:/SS/Yellowtail/Yellowtail2017/Models/North/20_tuned_jitter'
  jit.N <- SS_RunJitter(dir.N.jit, Njitter=100)


  
} # end if(FALSE) section that doesn't get sourced
