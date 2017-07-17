### notes on running profiles and making associated plots
### for 2017 Yellowtail Rockfish assessment
###
### NOTE: this file mostly just for the Northern model

# define directory on a specific computer
if (system("hostname", intern=TRUE) %in% c("NWCLW04223033") ){
  YTdir <- "C:/SS/Yellowtail/Yellowtail2017"
  YTdir.mods <- file.path(YTdir, "Models")
  YTdir.sens.N <- file.path(YTdir.mods, "North_sens_20")
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

##################################################################################
# STAR requests 

out.N.20b_added_variance <- SS_output(file.path(YTdir.mods,'North/20b_added_variance'))
# fit to indices 
png(file.path(YTdir.sens.N, 'index0_all_indices_added_variance.png'),
    width=6.5, height=5, res = 300, units = 'in')
par(mfrow=c(2,2),mar=c(2,2,2,1),oma=c(2,2,0,0)+.1)
SSplotIndices(out.N.20b_added_variance,subplot=2,datplot=FALSE) #,fleetnames=fleets)
mtext(side=1,line=1,outer=TRUE,'Year')
mtext(side=2,line=1,outer=TRUE,'Index')
dev.off()

# block selectivity
out.N.20c_block_rec_selex <- SS_output(file.path(YTdir.mods,'North/20c_block_rec_selex'),
                                       covar=FALSE)
# new WA comps
out.N.21 <- SS_output(file.path(YTdir.mods, 'North/21_new_WA_ages'))
SS_plots(out.N.21, datplot=TRUE, maxrows=6, maxcols=6)

# new WA comps AND block selectivity
out.N.22 <- SS_output(file.path(YTdir.mods, 'North/22_new_WA_ages_block_selex'))
SS_plots(out.N.22, datplot=TRUE, maxrows=6, maxcols=6)

out.N.23 <- SS_output(file.path(YTdir.mods, 'North/23_new_WA_ages_block_selex_dome'), covar=FALSE)
out.N.24 <- SS_output(file.path(YTdir.mods, 'North/24_extraVar_tune'), covar=FALSE)
out.N.25 <- SS_output(file.path(YTdir.mods, 'North/25_extraVar_tune_dome'), covar=FALSE)
out.N.26 <- SS_output(file.path(YTdir.mods, 'North/26_extraVar_tune_nodome'), covar=FALSE)
out.N.27 <- SS_output(file.path(YTdir.mods, 'North/27_with_hess'))
out.N.27b <- SS_output(file.path(YTdir.mods, 'North/27b_remove_logbook'))
out.N.27c <- SS_output(file.path(YTdir.mods, 'North/27c_remove_hake'))
out.N.27d <- SS_output(file.path(YTdir.mods, 'North/27d_remove_both'))
out.N.27e <- SS_output(file.path(YTdir.mods, 'North/27e_sigmaR0.5'))
out.N.27f <- SS_output(file.path(YTdir.mods, 'North/27f_remove_both_neg_fleet'))

SSplotComparisons(SSsummarize(list(out.N, out.N.27e, out.N.27d)),
                  indexfleets=1,
                  indexUncertainty=TRUE,
                  legendlabel=c('Northern Pre-STAR Base',
                      'Changes from morning plus tuning',
                      'Remove both fishery CPUE indices'),
                  print=TRUE, plotdir='C:/SS/Yellowtail/Yellowtail2017/YTRK_doc/Figures/STAR_requests_N3')
SSplotComparisons(SSsummarize(list(out.N, out.N.27e, out.N.27d)),
                  indexfleets=2, subplot=11:12,
                  indexUncertainty=TRUE,
                  legendlabel=c('Northern Pre-STAR Base',
                      'Changes from morning plus tuning',
                      'Remove both fishery CPUE indices'),
                  print=TRUE, plotdir='C:/SS/Yellowtail/Yellowtail2017/YTRK_doc/Figures/STAR_requests_N3')
SStableComparisons(SSsummarize(list(out.N, out.N.27e, out.N.27d)))


SSplotComparisons(SSsummarize(list(out.N, out.N.21, out.N.22, out.N.26, out.N.25)),
                  legendlabel=c('Base', 'Fix WA data', 'add 2003 block on rec selex',
                      'add extra variance and re-tune', 'allow dome-shaped rec selectivity'),
                  print=TRUE, plotdir='C:/SS/Yellowtail/Yellowtail2017/YTRK_doc/Figures/STAR_requests')
                  
### 1982 spike in rec selectivity
out.S_no_rec_catch_spike <- SS_output(file.path(YTdir.sens.S, "sens.S.no_rec_catch_spike"))
SSplotComparisons(SSsummarize(list(out.S, out.S_no_rec_catch_spike)), subplot=c(2,4),
                  legendlabels=c("status-quo catch","remove spike in 1982 rec catch"))
plot(out.S_no_rec_catch_spike$catch$kill_bio[out.S_no_rec_catch_spike$catch$Fleet==1], fleet=1, subplot=1)



out.N.27d <- SS_output(file.path(YTdir.mods, 'North/27d_remove_both'))
out.S2 <- SS_output('C:/SS/Yellowtail/Yellowtail2017/Models/South/STAR_2_SOUTH')
STAR2summary <- SSsummarize(list(out.N.27d, out.S2))

SSplotComparisons(STAR2summary, 
                  plot = FALSE, 
                  print = TRUE, 
                  plotdir = 'C:/SS/Yellowtail/Yellowtail2017/YTRK_doc/Figures/North_vs_South_July12',
                  spacepoints = 20,  # years between points on each line
                  initpoint = 0,     # "first" year of points (modular arithmetic)
                  staggerpoints = 0, # points aligned across models
                  endyrvec = 2017,   # final year to show in time series
                  legendlabels = c("Northern without fishery indices",
                      "Southern with matching M"),
                  filenameprefix = "STAR_July12_", 
                  col = c("blue","red"))

png('C:/SS/Yellowtail/Yellowtail2017/YTRK_doc/Figures/North_vs_South_July12/STAR_July12_Age4bio_compare.png',
    width=6.5, height=6, units='in', res=300)
compare_timeseries(out.N.27d, out.S2,
                   legendlabels=c("Northern without fishery indices",
                       "Southern with matching M"))
dev.off()


### STAR base North
base.N <- SS_output(file.path(YTdir.mods, 'North/STAR_2_NORTH'))

### STAR profiles
dir(file.path(YTdir.mods, 'profiles/STAR'))


# M high has M = 0.210
M_hi <- SS_output(file.path(YTdir.mods, 'profiles/STAR/fine1_prof.M.N.STAR2'),
                  repfile="Report8.sso", compfile="CompReport8.sso", covar=FALSE)
M_hi$derived_quants["SPB_2017","Value"]
## [1] 13.405

# M low has M = 0.134
M_lo <- SS_output(file.path(YTdir.mods, 'profiles/STAR/prof.M.N.STAR2'),
                  repfile="Report4.sso", compfile="CompReport4.sso", covar=FALSE)
M_lo$derived_quants["SPB_2017","Value"]
## [1] 9.14937

# R0 high has log(R0) = 11.21
R0_hi <- SS_output(file.path(YTdir.mods, 'profiles/STAR/prof.R0.N.STAR2'),
                  repfile="Report3.sso", compfile="CompReport3.sso", covar=FALSE)
R0_hi$derived_quants["SPB_2017","Value"]
## [1] 13.3914

# R0 low has log(R0) = 10.42
R0_lo <- SS_output(file.path(YTdir.mods, 'profiles/STAR/prof.R0.N.STAR2'),
                  repfile="Report6.sso", compfile="CompReport6.sso", covar=FALSE)
R0_lo$derived_quants["SPB_2017","Value"]
## [1] 9.15144

prof.sum <- SSsummarize(list(out.N, R0_lo, R0_hi, M_lo, M_hi))
SSplotComparisons(prof.sum, legendlabels=c("Base model","R0_lo","R0_hi","M_lo","M_hi"),
                  legendloc='bottomleft', new=FALSE, endyrvec=2027, subplot=2)

### change in selectivity for base model
SSplotSelex(out.N, subplot=1, fleets=3:4, years=1889:2017,
            pwidth=6.5, pheight=5,
            print=TRUE, plotdir=out.N$inputs$dir)
