### Run r4ss and notes for making model comparison plots and editing plots
### Originally developed for the 2015 China Rockfish assessment document, 
### which had three independent assessment models (South of 40-10, 
### 40-10 through OR, and WA). Written for up to 3 assessment models
### Even if you only have 1 assessment model, it will be called mod1 throughout
### 
### Section 1: run r4ss and create plots
###
### Section 2: has the code for multiple model plot comparisons 
### Edit Section 2 script based on your needs
### Don't source this code, unless you've made all necessary edits
###
### Section 3: save the entire myreplist and mod_structure files from r4ss as csv's
# =============================================================================

# start fresh here - this script is separate from the script for the assessment
# document
rm(list=ls(all=TRUE))


# SECTION1: Run r4ss, parse plotInfoTable.csv file, & add linebreaks to SS files

stop("\n  This file should not be sourced!") # note to stop from accidental sourcing

# Here we're going to make sure you have all the required packages for the template
# Check for installtion and make sure all R libraries can be loaded
# xtable for creating tables, ggplot2 for plotting, reshape2 for melting
# dataframes, scales for printing percents
# You may have to manually install knitr - reason unknown!

requiredPackages = c('xtable', 'ggplot2', 'reshape2', 'scales', 
                     'rmarkdown', 'knitr', 'devtools')

for(p in requiredPackages){
  if(!require(p,character.only = TRUE)) install.packages(p)
  library(p,character.only = TRUE)
}

# Install the latest version of r4ss using devtools
devtools::install_github("r4ss/r4ss")
library(r4ss)

# CHANGE values in this section ===============================================

# number of assessment models - this is run before the R_preamble.R, which also
# contains this value
 n_models = 2
 

# By default, you can only work in the directory containing the project
# Set the directory here if you're getting errors
# setwd('C:/Assessment_template')


# =============================================================================

# set input and output directories
input.dir = file.path(getwd(), 'SS')
output.dir = file.path(getwd(), 'r4ss')

# IF the r4SS subdirectories don't exist, create them
# Once you have your own SS files and want to save these plots
# Uncomment the /r4SS/ in the .gitignore file
dir.create(file.path(output.dir,'plots_mod1'))
dir.create(file.path(output.dir,'plots_mod2'))


# BEGIN r4ss===================================================================
# REMOVE OLD r4SS OUTPUT!!!!! -------------------------------------------------
# Run this deliberately - it deletes the r4SS output plots files
do.call(file.remove, list(list.files(file.path(output.dir, 'plots_mod1'),    full.names=TRUE)))
do.call(file.remove, list(list.files(file.path(output.dir, 'plots_mod2'),    full.names=TRUE)))
do.call(file.remove, list(list.files(file.path(output.dir, 'plots_compare'), full.names=TRUE)))

# Run r4ss for each model - **CHANGE DIRECTORY if necessary**
               mod1 = SS_output(dir = file.path(input.dir,'Base_model1'), forecast=T, covar=T, ncol=1000)
if(n_models>1){mod2 = SS_output(dir = file.path(input.dir,'Base_model2'), forecast=T, covar=T, ncol=1000)}

# Save the workspace an image
save.image('./r4ss/SS_output.RData')



# =============================================================================
# RUN r4ss plots for each model

# output directories
out.dir.mod1 = file.path(output.dir,'plots_mod1')
out.dir.mod2 = file.path(output.dir,'plots_mod2')
out.dir.mod3 = file.path(output.dir,'plots_mod3')


# Model 1
SS_plots(mod1,
         png = TRUE,
         html = FALSE,
         datplot = TRUE,
         uncertainty = TRUE,
         maxrows = 6, 
         maxcols = 6, 
         maxrows2 = 4, 
         maxcols2 = 4, 
         printfolder = '', 
         dir = out.dir.mod1)

# Model2
if(n_models > 1){
  SS_plots(mod2,
           png = TRUE,
           html = FALSE,
           datplot = TRUE,
           uncertainty = TRUE,
           maxrows = 6, 
           maxcols = 6, 
           maxrows2 = 4, 
           maxcols2 = 4, 
           printfolder = '', 
           dir = out.dir.mod2)
}

# -----------------------------------------------------------------------------

# Run the code to parse the plotInfoTable files
source('./Rcode/Parse_r4ss_plotInfoTable.R')

# -----------------------------------------------------------------------------

# Create the SS files for the appendices
source('./Rcode/SS_files_linebreaks.R')

# =============================================================================
# END SECTION 1================================================================
# =============================================================================
# =============================================================================



# SECTION 2: COMPARISON PLOTS ACROSS MODELS ===================================
# IT it not recommended to blindly run this section.  You'll need to change names,
# possibly margins, etc!!!


if(n_models > 1){

 # if you need to reload the workspace
 load("./r4ss/SS_output.RData")
  
 # create base model summary list
 out.mod1 = mod1
 out.mod2 = mod2
if(n_models==3) {out.mod3 = mod3}
     
 
# base.summary <-  SSsummarize(list(out.mod1, out.mod2))
 
 
 base.summary <-  if (n_models==2) {SSsummarize(list(out.mod1, out.mod2))} else
                   {SSsummarize(list(out.mod1, out.mod2 , out.mod3))}
    
 # save results to this comparison directory  
 dir.create(file.path(output.dir,'plots_compare'))
 dir.compare.plots <- file.path(getwd(),'/r4ss/plots_compare') 
    
 # vector of names and colors models as defined
 mod.names <- c("Northern","Southern")
 mod.cols  <- c("blue", "red")
} # end n_models if




# Time series comparison plots for exec summary -------------------------------
# These plots are repeated with regular plots
SSplotComparisons(base.summary, 
                  plot = FALSE, 
                  print = TRUE, 
                  plotdir = dir.compare.plots,
                  spacepoints = 20,  # years between points on each line
                  initpoint = 0,     # "first" year of points (modular arithmetic)
                  staggerpoints = 0, # points aligned across models
                  endyrvec = 2017,   # final year to show in time series
                  legendlabels = mod.names, 
                  filenameprefix = "base_", 
                  col = mod.cols)

SSplotComparisons(base.summary, 
                  plot = FALSE, 
                  print = TRUE, 
                  plotdir = dir.compare.plots,
                  subplot = 1:10,
                  spacepoints = 20,  # years between points on each line
                  initpoint = 0,     # "first" year of points (modular arithmetic)
                  staggerpoints = 0, # points aligned across models
                  endyrvec = 2027,   # final year to show in time series
                  legendlabels = mod.names, 
                  filenameprefix = "forecast_", 
                  col = mod.cols)
  
  
  
# Plot comparison of growth curves --------------------------------------------
png(file.path(dir.compare.plots, 'growth_comparison.png'),
    width = 6.5, 
    height = 4, 
    res = 300, 
    units = 'in')

### make 2-panel plot to compare growth across models
par(mfrow=c(1,2), mar=c(0,0,0,1), oma=c(4,4,1,0), las=1)

# empty plot for 1st model with axis labels in outer margins
plot(0, type='n', xlim=c(0,40), ylim=c(0,65), xaxs='i', yaxs='i')
mtext(side=1, line=2.5, outer=TRUE, text="Age (yr)")
mtext(side=2, line=2.5, outer=TRUE, text="Length (cm)", las=0)
# add growth curves
SSplotBiology(mod1, subplot=1, add=TRUE, legendloc="bottomright")
# add legend, grid, and outer box
legend('topleft', title="Northern", legend=NA, bty="n", text.font=2)
grid()
box()

# empty plot for 2nd model
plot(0, type='n', xlim=c(0,40), ylim=c(0,65), axes=FALSE, xaxs='i', yaxs='i')
# add growth curves 
SSplotBiology(mod2, subplot=1, legendloc=NA, add=TRUE)
# add legend, grid, and outer box
legend('topleft', title="Southern", legend=NA, bty="n", text.font=2)
axis(1)
grid()
box()
# close PNG file
dev.off()


# Plot comparison of yield curves ---------------------------------------------
png(file.path(dir.compare.plots, 'yield_comparison_n_models.png'),
    width = 6.5, 
    height = 6.5, 
    res = 300, 
    units = 'in', 
    pointsize = 10)
par(las = 1)

SSplotYield(out.mod1, col = mod.cols[1], subplot = 1)
SSplotYield(out.mod2, col = mod.cols[2], subplot = 1, add = TRUE)
legend('topright', col=mod.cols, legend=mod.names, lwd=2, bty='n')
grid()
# close PNG file
dev.off()

# =============================================================================
# END SECTION 2================================================================
# =============================================================================




# =============================================================================
# Section 3: saves entire myreplist and mod_structure files 
# writes the entire myreplist and mod structure to a file
# useful if you need to find a particular variable r4ss creates
# change model and directory

#sink("./r4ss/plots_mod1/list_of_dataframes.csv", type="output")
#invisible(lapply(mod1, function(x) dput(write.csv(x))))
#sink()

#sink("./r4ss/plots_mod1/mod_structure.csv", type="output")
#invisible(str(mod1,list.len = 9999))
#sink()
