### notes on running retrospective analyses and making associated plots
### for China Rockfish assessment
### started 6/15/15

stop("\n  This file should not be sourced!") # note to stop Ian from accidental sourcing


# define directory on a specific computer
if (system("hostname", intern=TRUE) %in% c("NWCLW04223033") ){
  YTdir <- "C:/SS/Yellowtail/Yellowtail2017"
  YTdir.mods <- file.path(YTdir, "Models")
  # example sourcing this file
  # source("c:/SS/Yellowtail/Yellowtail2017/YTRK_doc/Rcode/miscellaneous/Yellowtail_retrospectives.R")
}

if (!system("hostname", intern=TRUE) %in% c("NWCLW04223033") ){
  YTdir <- "C://Users/Andi.Stephens/"
  YTdir.mods <- file.path(YTdir, "YTRK_Models")
  # example sourcing this file
  # source("c:/SS/Yellowtail/Yellowtail2017/YTRK_doc/Rcode/miscellaneous/Yellowtail_retrospectives.R")
}
require(r4ss)

# load model output into R
# read base model from each area
mod.S <- 'New_South_20/21_newbase'
dir.S <- file.path(YTdir.mods, mod.S)
out.S <- SS_output(dir.S)

mod.N <- 'North/20_tuned'
dir.N <- file.path(YTdir.mods, mod.N)
out.N <- SS_output(dir.N)

# create new folder to contain all retrospectives
dir.create(file.path(YTdir.mods, "retrospectives"))

####################################################################################
# run retros
####################################################################################

# retro North
dir.retro.N <- file.path(YTdir.mods, "retrospectives", "retro.N")
SS_doRetro(masterdir=dir.N, oldsubdir="", newsubdir="../../retrospectives/retro.N",
           years=0:-5)

# retro South
dir.retro.S <- file.path(YTdir.mods, "retrospectives", "retro.S")
SS_doRetro(masterdir=dir.S, oldsubdir="", newsubdir="../../retrospectives/retro.S",
           years=0:-5)

####################################################################################
# plot retro results
####################################################################################

legendlabels <- c("Base Model", paste("Data",-1:-5,"years"))

# retro North
# make time-series plots
retroMods.N <- SSgetoutput(dirvec=file.path(YTdir.mods, 'retrospectives/retro.N',
                               paste("retro",0:-5,sep="")))
# replace one that had a bad Hessian
## retroMods.N[[6]] <- SS_output(file.path(YTdir.mods,
##                                         'retrospectives/retro.N/retro-5_nohess'))
retroSummary <- SSsummarize(retroMods.N)
endyrvec <- retroSummary$endyrs + 0:-5
# general timeseries plots
SSplotComparisons(retroSummary, endyrvec=endyrvec, png=TRUE, indexUncertainty=TRUE,
                  plotdir=file.path(YTdir.mods, 'retrospectives/retro.N'),
                  filenameprefix="retro.N_", 
                  legendlabels=paste("Data",0:-5,"years"))
# fits to indices
for(index in unique(retroSummary$indices$Fleet)){
  SSplotComparisons(retroSummary, endyrvec=endyrvec, png=TRUE, indexUncertainty=TRUE,
                    plotdir=file.path(YTdir.mods, 'retrospectives/retro.N'),
                    subplot=11:12,indexfleets=index,
                    filenameprefix="retro.N_", 
                    legendlabels=paste("Data",0:-5,"years"))
}

# retro South
# make time-series plots
retroMods.S <- SSgetoutput(dirvec=file.path(YTdir.mods, 'retrospectives/retro.S',
                               paste("retro",0:-5,sep="")))
retroSummary <- SSsummarize(retroMods.S)
endyrvec <- retroSummary$endyrs + 0:-5
# general timeseries plots
SSplotComparisons(retroSummary, endyrvec=endyrvec, png=TRUE, indexUncertainty=TRUE,
                  plotdir=file.path(YTdir.mods, 'retrospectives/retro.S'),
                  legendloc='bottomleft',
                  filenameprefix="retro.S_", 
                  legendlabels=legendlabels)
# fits to indices
for(index in unique(retroSummary$indices$Fleet)){
  SSplotComparisons(retroSummary, endyrvec=endyrvec, png=TRUE, indexUncertainty=TRUE,
                    plotdir=file.path(YTdir.mods, 'retrospectives/retro.S'),
                    subplot=11:12,indexfleets=index,
                    filenameprefix="retro.S_", 
                    legendlabels=legendlabels)
}

### then copy figures into YTRK_doc\Figures\retrospectives\ for inclusion in repository
