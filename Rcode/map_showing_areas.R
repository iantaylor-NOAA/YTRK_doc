############################################################################
# map showing areas used in 2017 Yellowtail Rockfish stock assessment

# analyses related to triennial survey
# (data provided by John Wallace on 3-22-17 in email titled
#  "AK surveys for Yellowtail")

if (system("hostname", intern=TRUE) %in% c("NWCLW04223033") ){
  YTdir <- "C:/SS/Yellowtail/Yellowtail2017"
  figsdir <- file.path(YTdir, "YTRK_doc/Figures")
}

# define names and colors for each area
mod.names <- c("North","South")
mod.cols  <- c("blue",  "red")
# load packages
require(maps)
require(mapdata)

# open PNGfile
png(file.path(figsdir, 'assess_region_map.png'),
    width=6.5, height=8, res=350, units='in')
# map with Canada and Mexico (not sure how to add states on this one)
map('worldHires', regions=c("Canada","Mexico"),
    xlim=c(-130, -114), ylim=c(31, 51),
    col='grey', fill=TRUE, interior=TRUE, , lwd=1)
# horizontal line at 40-10
abline(h=c(40+10/60), lty=3)
# map with US states
map('state', regions=c("Wash","Oreg","Calif","Idaho",
                 "Montana","Nevada","Arizona","Utah"),
    add=TRUE,
    col='grey', fill=TRUE, interior=TRUE, lwd=1)
axis(2, at=seq(32,50,2), lab=paste0(seq(32,50,2), "°N"), las=1)
axis(1, at=seq(-130,-114,4), lab=paste0(abs(seq(-130,-114,4)), "°W"))
#map.axes()

## add vertical lines indicating range for each stock
latrange <- c(40+10/60, 48.5) + c(.2, -.2)
lines(rep(-126,2), latrange, lwd=10, col=mod.cols[1])
text(-126-.8, mean(latrange), mod.names[1], srt=90)
latrange <- c(32.5, 40+10/60) + c(.2, -.2)
lines(rep(-126,2), latrange, lwd=10, col=mod.cols[2])
text(-126-.8, mean(latrange), mod.names[2], srt=90)
#
text(-122, 50, "Canada")
text(-120, 47.75, "Washington")
text(-121, 44, "Oregon")
text(-120, 37, "California")
text(-115.5, 32.1, "Mexico")
#
box()
dev.off()
