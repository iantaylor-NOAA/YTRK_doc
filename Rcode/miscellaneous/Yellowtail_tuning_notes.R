# Note: stuff below has all be replaced by
# new r4ss function: SS_tune_comps




## # define directory on a specific computer
## if (system("hostname", intern=TRUE) %in% c("NWCLW04223033") ){
##   YTdir <- "C:/SS/Yellowtail/Yellowtail2017"
##   YTdir.mods <- file.path(YTdir, "Models")
## }

## # load model output into R
## old.mod <- 'South/12c_extraSD_rec'
## new.mod <- 'South/12e_extraSD_rec_tune'

## old.mod <- 'North/16f_natM_estFoffset'
## new.mod <- 'North/17_tuned'

## replist <- SS_output(file.path(YTdir.mods, old.mod))
## newdir <- file.path(YTdir.mods, new.mod)

## # get table of variance adjustments
## adjustments_old <- SS_varadjust(dir=replist$inputs$dir,
##                                 ctlfile=replist$Control_File)
## # make a copy of the table to modify
## adjustments_new <- adjustments_old
## # loop over fleets and modify the values for length data
## for(ifleet in unique(replist$lendbase$Fleet)){
##   # run the Francis function for length comps
##   # (reports a vector with proposed adjustment, low, and high values)
##   Francis.vals <- SSMethod.TA1.8(fit=replist, type='len',
##                                  fleet=ifleet, plotit=FALSE)
##   # get adjustment for length comps (Factor 4) and this fleet
##   Var_adj_old <- adjustments_old$Var_Adj[adjustments_old$Factor==4 &
##                                            adjustments_old$Fleet==ifleet]
##   # multiply old value by proposed multiplier
##   Var_adj_new <- Var_adj_old*Francis.vals[1]
##   # fill value into table
##   adjustments_new$Var_Adj[adjustments_new$Factor==4 &
##                             adjustments_new$Fleet==ifleet] <- Var_adj_new
## }
## # loop over fleets and modify the values for age data
## for(ifleet in unique(replist$agedbase$Fleet)){
##   # run the Francis function for length comps
##   # (reports a vector with proposed adjustment, low, and high values)
##   Francis.vals <- SSMethod.TA1.8(fit=replist, type='age',
##                                  fleet=ifleet, plotit=FALSE)
##   # get adjustment for conditional age-at-length (Factor 5) and this fleet
##   Var_adj_old <- adjustments_old$Var_Adj[adjustments_old$Factor==5 &
##                                            adjustments_old$Fleet==ifleet]
##   # multiply old value by proposed multiplier
##   Var_adj_new <- Var_adj_old*Francis.vals[1]
##   # fill value into table
##   adjustments_new$Var_Adj[adjustments_new$Factor==5 &
##                             adjustments_new$Fleet==ifleet] <- Var_adj_new
## }
## # loop over fleets and modify the values for Conditional Age-at-Length data
## for(ifleet in unique(replist$condbase$Fleet)){
##   # run the Francis function for length comps
##   # (reports a vector with proposed adjustment, low, and high values)
##   Francis.vals <- SSMethod.Cond.TA1.8(fit=replist, 
##                                       fleet=ifleet, plotit=FALSE)
##   # get adjustment for conditional age-at-length (Factor 5) and this fleet
##   Var_adj_old <- adjustments_old$Var_Adj[adjustments_old$Factor==5 &
##                                            adjustments_old$Fleet==ifleet]
##   # multiply old value by proposed multiplier
##   Var_adj_new <- Var_adj_old*Francis.vals[1]
##   # fill value into table
##   adjustments_new$Var_Adj[adjustments_new$Factor==5 &
##                             adjustments_new$Fleet==ifleet] <- Var_adj_new
## }
## adjustments_new$comment <- "#"
## adjustments_new$Old_Var_Adj <- adjustments_old$Var_Adj

## if(replist$FleetNames[4]=="HookAndLineSurvey"){
##   # use McAllister-Ianelli for hook and line survey with only 1 year 
##   adjustments_new$Var_Adj[adjustments_new$Factor==5 & adjustments_new$Fleet==4] <-
##     replist$Age_comp_Eff_N_tuning_check$Recommend_Var_Adj[replist$Age_comp_Eff_N_tuning_check$Fleet==4]
## }

## # show new table
## print(adjustments_new)

## # write new table to file
## SS_varadjust(dir=replist$inputs$dir, ctlfile=replist$Control_File,
##              newctlfile=file.path('../..', new.mod, replist$Control_File),
##              newtable=adjustments_new[,1:3], overwrite=TRUE)
