# plot showing time-varying retention for the Northern model
# in the 2017 Yellowtail Assessment

par(las = 1, mar=c(4,4,1,1))

# extra selectivity plot to show time-varying retention
infotable <- SSplotSelex(mod1, fleets=1, sizefactors="Ret",
                         years=1800:2050, subplot=1)$infotable
# replace all blue with vector of colors and remove points
infotable$col <- rich.colors.short(nrow(infotable))
infotable$pch <- NA
infotable$lty <- 1
infotable$longname <- infotable$Yr_range
# make plot
SSplotSelex(mod1, infotable=infotable, fleets=1, sizefactors="Ret",
            labels = c("Length (cm)", "Age (yr)", "Year",
                "Retention", # replace Selectivity with retention as 4th label
                "Retention", "Discard mortality"),
            legendloc='topleft', years=1800:2050, subplot=1, showmain=FALSE)

