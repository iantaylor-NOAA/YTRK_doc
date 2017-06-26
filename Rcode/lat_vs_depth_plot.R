############################################################################
# map showing hauls in NWFSC survey with Yellowtail catch
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
  }
}


plot(-Surv.Hauls$BEST_DEPTH_M, Surv.Hauls$BEST_LAT_DD, pch=".",
     col=rgb(1,0,0,.4), xlim=c(-250,-50))
# positive hauls
points(-Surv.Hauls$BEST_DEPTH_M, Surv.Hauls$BEST_LAT_DD, pch=16,
       cex=0.15*sqrt(Surv.Hauls$HAUL_WT_KG/Surv.Hauls$AREA_SWEPT_HA), col=rgb(0,0,1,.3))
grid()
