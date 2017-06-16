############################################################################
# map showing areas used in 2017 Yellowtail Rockfish stock assessment

if (system("hostname", intern=TRUE) %in% c("NWCLW04223033") ){
  YTdir <- "C:/SS/Yellowtail/Yellowtail2017"
  setwd(file.path(YTdir, "YTRK_doc"))
}

# define names and colors for each area
mod.names <- c("Northern","Southern")
mod.cols  <- c("blue",  "red")
mod.cols  <- c(rgb(0.3,0.3,1,1), rgb(1,0.3,0.3,1)) # slightly more pale versions
# load packages
require(maps)
require(mapdata)

# CSV file with EEZ created by Ian from KML file available from
# http://www.nauticalcharts.noaa.gov/csdl/mbound.htm#data
eez <- read.csv('txt_files/EEZ_polygon_lat_lon.csv')
boundary.N <- eez[eez$lat > 40+10/60,]

# open PNGfile
png('Figures/assess_region_map_v2.png',
    width=6.5, height=8, res=350, units='in')
par(mar=c(3,3,.1,.1))
# map with Canada and Mexico (not sure how to add states on this one)
map('worldHires', regions=c("Canada","Mexico"),
    xlim=c(-130, -114), ylim=c(30, 51),
    col='grey', fill=TRUE, interior=TRUE, lwd=1)
polygon(eez$lon, eez$lat, col=mod.cols[2], border=FALSE)
polygon(boundary.N$lon, boundary.N$lat, col=mod.cols[1], border=FALSE)
# horizontal line at 40-10
abline(h=c(40+10/60), lty=3)
text(-127, 40, "40°10'", pos=3)
# map with US states
map('state', regions=c("Wash","Oreg","Calif","Idaho",
                 "Montana","Nevada","Arizona","Utah"),
    add=TRUE,
    col='grey', fill=TRUE, interior=TRUE, lwd=1)
axis(2, at=seq(30,50,2), lab=paste0(seq(30,50,2), "°N"), las=1)
axis(1, at=seq(-130,-114,4), lab=paste0(abs(seq(-130,-114,4)), "°W"))
#map.axes()

text(-127, 44, mod.names[1], font=2)
text(-123, 35, mod.names[2], font=2)

#### add vertical lines indicating range for each stock
## latrange <- c(40+10/60, 48.5) + c(.2, -.2)
## lines(rep(-126,2), latrange, lwd=10, col=mod.cols[1])
## text(-126-.8, mean(latrange), mod.names[1], srt=90)
## latrange <- c(32.5, 40+10/60) + c(.2, -.2)
## lines(rep(-126,2), latrange, lwd=10, col=mod.cols[2])
## text(-126-.8, mean(latrange), mod.names[2], srt=90)
#
text(-122, 50, "Canada")
text(-120, 47.75, "Washington")
text(-121, 44, "Oregon")
text(-120, 37, "California")
text(-115.5, 32.1, "Mexico")
#
box()
dev.off()
