#V3.30.03.05
#_data_and_control_files: YTRK.South.data.ss // YTRK.South.control.ss
#_SS-V3.30.03.05-safe;_2017_05_11;_Stock_Synthesis_by_Richard_Methot_(NOAA)
# _using_ADMB_11.6
#_SS-V3.30.03.05-safe;user_support_available_at:NMFS.Stock.Synthesis@noaa.g
# ov
#_SS-V3.30.03.05-safe;user_info_available_at:https://vlab.ncep.noaa.gov/gro
# up/stock-synthesis
#
#
#
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and al
# so read and use growth parameters
1  #_N_Growth_Patterns
1  #_N_platoons_Within_GrowthPattern 
#
#
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond 1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)
#
2 # recr_dist_method for parameters:  1=like 3.24; 2=main effects for GP, S
# ettle timing, Area; 3=each Settle entity; 4=none when N_GP*Nsettle*pop==1
1 # Recruitment: 1=global; 2=by area (future option)
1 #  number of recruitment settlement assignments 
0 # year_x_area_x_settlement_event interaction requested (only for recr_dis
# t_method=1)
#
#
#GPat month  area age (for each settlement assignment)
#
1 1 1 0
#
#
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer
# ) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1
#  dest=2, age1=4, age2=10
#
#
1 #_Nblock_Patterns
2 #_Blocks per pattern
1980 1989  1990 2016
#
#_Cond 0 #_blocks_per_pattern 
# begin and end years of blocks
#
# controls for all timevary parameters 
#
#
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to
#  base parm bounds; 3=no bound check)
#
#  autogen
#
1 1 1 1 1 # autogen
#
# where: 0 = autogen all time-varying parms; 1 = read each time-varying par
# m line; 2 = read then autogen if min=-12345
# 1st element for biology, 2nd for SR, 3rd for Q, 5th for selex, 4th reserv
# ed
#
## setup for M, growth, maturity, fecundity, recruitment distibution, movem
# ent 
#
#
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agesp
# ec_withseasinterpolate
1 #_GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specifi
# c_K; 4=not implemented
#
#
#
1  #_Growth_Age_for_L1
25 #_Growth_Age_for_L2 (999 to use as Linf)
#
#
-999 #_exponential decay for growth above maxage (fixed at 0.2 in 3.24; val
# ue should approx initial Z; -999 replicates 3.24)
#
#
#
0 #_placeholder for future growth feature
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 l
# ogSD=F(A)
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturit
# y matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read leng
# th-maturity
5 #_First_Mature_Age
2 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)e
# ggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=
# male-to-female age-specific fxn
2 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-
# GP1, 3=like SS2 V1.x)
#
#_growth_parms
#_LO    HI      INIT    PRIOR   PR_SD   PR_type PHASE   env-var use_dev dev
# _mnyr dev_mxyr dev_PH Block  Blk_Fxn # parm_name
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev
# _maxyr dev_PH Block Block_Fxn
0.02 0.25 0.18 -2.12 0.438 0 -2 0 0 0 0 0 0 0 # NatM_p_1_Fem_GP_1
1 25 18.5693 22 99 0 3 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
35 70 49.5336 55 99 0 2 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
0.1 0.4 0.110307 0.1 99 0 3 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
0.03 0.16 0.0759611 0.1 99 0 5 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
0.03 0.16 0.0569237 0.1 99 0 5 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
0 3 1.1843e-005 99 99 0 -50 0 0 0 0 0 0 0 # Wtlen_1_Fem
2 4 3.0672 99 99 0 -50 0 0 0 0 0 0 0 # Wtlen_2_Fem
30 56 42.49 42.49 99 0 -50 0 0 0 0 0 0 0 # Mat50%_Fem
-2 1 -0.40078 -0.40078 99 0 -50 0 0 0 0 0 0 0 # Mat_slope_Fem
0 6 1.1185e-011 99 99 0 -50 0 0 0 0 0 0 0 # Eggs_scalar_Fem
2 7 4.59 4.59 99 0 -50 0 0 0 0 0 0 0 # Eggs_exp_len_Fem
-3 3 -0.2876 0 99 6 -2 0 0 0 0 0 0 0 # NatM_p_1_Mal_GP_1
-1 1 0 0 99 0 -2 0 0 0 0 0 0 0 # L_at_Amin_Mal_GP_1
-1 1 -0.122881 0 99 0 2 0 0 0 0 0 0 0 # L_at_Amax_Mal_GP_1
-1 1 0.122504 0 99 0 3 0 0 0 0 0 0 0 # VonBert_K_Mal_GP_1
-1 1 0 0 99 0 -5 0 0 0 0 0 0 0 # CV_young_Mal_GP_1
-1 1 0.372783 0 99 0 5 0 0 0 0 0 0 0 # CV_old_Mal_GP_1
0 3 1.1843e-005 99 99 0 -50 0 0 0 0 0 0 0 # Wtlen_1_Mal
2 4 3.0672 99 99 0 -50 0 0 0 0 0 0 0 # Wtlen_2_Mal
0 2 1 1 99 0 -50 0 0 0 0 0 0 0 # RecrDist_GP_1
0 2 1 1 99 0 -50 0 0 0 0 0 0 0 # RecrDist_Area_1
0 2 1 1 99 0 -50 0 0 0 0 0 0 0 # RecrDist_month_1
1 1 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
0.001 0.999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#
#
#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
#
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,m
# alewtlen2,L1,K
#
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
#_Spawner-Recruitment
#
3 #_SR_function: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=su
# rvival_3Parm; 8=Shepard_3Parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvatu
# re
#
#
#_LO    HI    INIT   PRIOR   PR_SD   PR_type  PHASE  env-var  use_dev dev_m
# nyr dev_mxyr   dev_PH  Block  Blk_Fxn #  parm_name
#
     5      20    12    10        5     0    1    0    0    0    0    0    
0    0 # SR_LN(R0)
#
#
### if fixing steepness, use line below
    0.2     1       0.718   0.718   0.158   0       -6      0       0      
 0       0       0       0       0       # SR_BH_steep
### if estimating steepness, use line below with Type-C prior for Yellowtai
# l
    #0.2     1       0.4     0.715   0.160   0       6       0       0     
#   0       0       0       0       0       # SR_BH_steep
#
#
     0.5     1.2   0.85  0.76    99     0   -6    0    0    0    0    0    
0    0 # SR_sigmaR
    -5       5     0     0       99     0   -50   0    0    0    0    0    
0    0 # SR_regime
     0       2     0     1       99     0   -50   0    0    0    0    0    
0    0 # SR_autocorr
#
#
1 #do_recdev:  0=none; 1=devvector; 2=simple deviations
1965 # first year of main recr_devs; early devs can preceed this era
2015 # last year of main recr_devs; forecast devs start in following year
2 #_recdev phase 
#
#
1 # (0/1) to read 13 advanced options
1945 #_recdev_early_start (0=none; neg value makes relative to recdev_start
# )
5 #_recdev_early_phase
5 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphas
# e+1)
#
1 #_lambda for Fcast_recr_like occurring before endyr+1
#
1963.9   #_last_early_yr_nobias_adj_in_MPD 
1971.7   #_first_yr_fullbias_adj_in_MPD 
2003.0   #_last_yr_fullbias_adj_in_MPD 
2017.9   #_first_recent_yr_nobias_adj_in_MPD 
0.6972   #_max_bias_adj_in_MPD (1.0 to mimic pre-2009 models)   
0 #_period of cycles in recruitment (N parms read below)
-6 #min rec_dev
6 #max rec_dev
0 #_read_recdevs
#_end of advanced SR options
#
#
#
#Fishing Mortality info 
0.3 # F ballpark
1984 # F ballpark year (neg value to disable)
1 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
0.95 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed input
# s to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
#
#
#
#_initial_F_parms; count = 0
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#
#_Q_setup
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         1         1         0         1         0         1  #  Recreation
# alCatch
         3         1         0         0         0         1  #  OnboardSur
# vey
         4         1         0         0         0         1  #  HookAndLin
# eSurvey
  5         1         0         0         0         1  #  Small_Fish_Study
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_LO   HI    INIT   PRIOR   PR_SD   PR_type  PHASE  env-var  use_dev dev_mn
# yr dev_mxyr   dev_PH  Block  Blk_Fxn  #  parm_name
-30    15   -15.817     0     1     0   -1    0    0    0    0    0    0   
 0  #  LnQ_base_RecreationalCatch
0      0.5    0.01      0     1     0    1    0    0    0    0    0    0   
 0  #  Extra_SD_rec
-30    15   -15.817     0     1     0   -1    0    0    0    0    0    0   
 0  #  LnQ_base_OnboardSurvey
-30    15   -15.817     0     1     0   -1    0    0    0    0    0    0   
 0  #  LnQ_base_HookAndLineSurvey
-30    15   -15.817     0     1     0   -1    0    0    0    0    0    0   
 0  #  LnQ_Small_Fish_Study
#
#_no timevary Q parameters
#
#_size_selex_types
#discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_
# discarded_dead
#
#_Pattern Discard Male Special
#
24  0 0 0 # 1 RecreationalCatch
24  0 0 0 # 2 CommercialCatch
24  0 0 0 # 3 OnboardSurvey
24  0 0 0 # 4 HookAndLineSurvey
24  0 0 0 # 5 RecStudy
#
#_age_selex_types
#_Pattern Discard Male Special
#
10 0 0 0 # 1 RecreationalCatch
10 0 0 0 # 2 CommercialCatch
10 0 0 0 # 3 OnboardSurvey
10 0 0 0 # 4 HookAndLineSurvey
10 0 0 0 # 5 RecStudy
#
20    55    30.201     0    99     0  1  0  0  0  0  0  0  0  #  SizeSel_P1
# _RecreationalCatch(1)
 -20    20    20     0    99     0     -4  0  0  0  0  0  0  0  #  SizeSel_
# P2_RecreationalCatch(1)
  -5    20   3.55447     0    99     0  3  0  0  0  0  0  0  0  #  SizeSel_
# P3_RecreationalCatch(1)
  -5    20    20     0    99     0     -4  0  0  0  0  0  0  0  #  SizeSel_
# P4_RecreationalCatch(1)
-999    25  -999     0    99     0    -99  0  0  0  0  0  0  0  #  SizeSel_
# P5_RecreationalCatch(1)
-999    25  -999     0    99     0    -99  0  0  0  0  0  0  0  #  SizeSel_
# P6_RecreationalCatch(1)
  20    55    55     0    99     0     -1  0  0  0  0  0  0  0  #  SizeSel_
# P1_CommercialCatch(2)
 -20    20    20     0    99     0     -4  0  0  0  0  0  0  0  #  SizeSel_
# P2_CommercialCatch(2)
  -5    20    5.2631     0    99     0  3  0  0  0  0  0  0  0  #  SizeSel_
# P3_CommercialCatch(2)
  -5    20    20     0    99     0     -4  0  0  0  0  0  0  0  #  SizeSel_
# P4_CommercialCatch(2)
-999    25  -999     0    99     0    -99  0  0  0  0  0  0  0  #  SizeSel_
# P5_CommercialCatch(2)
-999    25  -999     0    99     0    -99  0  0  0  0  0  0  0  #  SizeSel_
# P6_CommercialCatch(2)
  20    55   30.2914     0    99     0  1  0  0  0  0  0  0  0  #  SizeSel_
# P1_OnboardSurvey(3)
 -20     7   -20     0    99     0     -4  0  0  0  0  0  0  0  #  SizeSel_
# P2_OnboardSurvey(3)
  -5    20   3.54627     0    99     0  3  0  0  0  0  0  0  0  #  SizeSel_
# P3_OnboardSurvey(3)
  -5    20   7.91106     0    99     0  4  0  0  0  0  0  0  0  #  SizeSel_
# P4_OnboardSurvey(3)
-999    25  -999     0    99     0    -99  0  0  0  0  0  0  0  #  SizeSel_
# P5_OnboardSurvey(3)
-999    25  -999     0    99     0    -99  0  0  0  0  0  0  0  #  SizeSel_
# P6_OnboardSurvey(3)
  20    55   47.9691     0    99     0  1  0  0  0  0  0  0  0  #  SizeSel_
# P1_HookAndLineSurvey(4)
 -20    20    20     0    99     0     -4  0  0  0  0  0  0  0  #  SizeSel_
# P2_HookAndLineSurvey(4)
  -5    20   5.13065     0    99     0  3  0  0  0  0  0  0  0  #  SizeSel_
# P3_HookAndLineSurvey(4)
  -5    20    20     0    99     0     -4  0  0  0  0  0  0  0  #  SizeSel_
# P4_HookAndLineSurvey(4)
-999    25  -999     0    99     0    -99  0  0  0  0  0  0  0  #  SizeSel_
# P5_HookAndLineSurvey(4)
-999    25  -999     0    99     0    -99  0  0  0  0  0  0  0  #  SizeSel_
# P6_HookAndLineSurvey(4)
  20    55    49.124     0    99     0  1  0  0  0  0  0  0  0  #  SizeSel_
# P1_RecStudy(5)
 -20    20    20     0    99     0     -4  0  0  0  0  0  0  0  #  SizeSel_
# P2_RecStudy(5)
  -5    20   5.34296     0    99     0  3  0  0  0  0  0  0  0  #  SizeSel_
# P3_RecStudy(5)
  -5    20    20     0    99     0     -4  0  0  0  0  0  0  0  #  SizeSel_
# P4_RecStudy(5)
-999    25  -999     0    99     0    -99  0  0  0  0  0  0  0  #  SizeSel_
# P5_RecStudy(5)
-999    25  -999     0    99     0    -99  0  0  0  0  0  0  0  #  SizeSel_
# P6_RecStudy(5)
#
#
#
#
#_no timevary selex parameters
#
## 20      55      35      0       99      0       1
## 20      55      35      0       99      0       1
## -5      20      55      0       99      0       4
## -5      20      55      0       99      0       4
#
#
#
0   #  use 2D_AR1 selectivity(0/1):  experimental feature
#_no 2D_AR1 selex offset used
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# no timevary parameters
#
#
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
#
#
#Factor Fleet New_Var_adj hash Old_Var_adj New_Francis New_MI Francis_mult 
# MI_mult Type Name Note
4 1 0.004255 # 0.004518 0.004255 0.016144 0.941808 3.573368 len Recreationa
# lCatch 
4 2 0.317319 # 0.306952 0.317319 0.487048 1.033775 1.586723 len CommercialC
# atch 
4 3 0.003935 # 0.004079 0.003935 0.006097 0.964706 1.494771 len OnboardSurv
# ey 
4 4 0.958017 # 0.983092 0.958017 2.049982 0.974494 2.085239 len HookAndLine
# Survey 
4 5 0.686709 # 0.632519 0.686709 1.036285 1.085673 1.638346 len RecStudy 
5 1 0.059082 # 0.065085 0.059082 0.331402 0.907774 5.09183 age Recreational
# Catch 
5 2 0.1169 # 0.136786 0.1169 0.212324 0.854621 1.552233 age CommercialCatch
#  
5 4 0.205322 # 0.21157 NA 0.205322 NA 0.97047 age HookAndLineSurvey No Fran
# cis weight--using MI value
#
#
-9999   1       0.000000000
#
#
#
5 #_maxlambdaphase
1 #_sd_offset
# read 0 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=
# sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag
# -comp; 16=Tag-negbin; 17=F_ballpark
#like_comp fleet  phase  value  sizefreq_method
17     1  5  0  0 # turn off ballpark likelihood in phase 5
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  1 #_CPUE/survey:_1
#  0 #_CPUE/survey:_2
#  0 #_CPUE/survey:_3
#  0 #_CPUE/survey:_4
#  0 #_CPUE/survey:_5
#  1 #_discard:_1
#  0 #_discard:_2
#  0 #_discard:_3
#  0 #_discard:_4
#  0 #_discard:_5
#  1 #_lencomp:_1
#  0 #_lencomp:_2
#  0 #_lencomp:_3
#  0 #_lencomp:_4
#  0 #_lencomp:_5
#  1 #_agecomp:_1
#  0 #_agecomp:_2
#  0 #_agecomp:_3
#  0 #_agecomp:_4
#  0 #_agecomp:_5
#  1 #_init_equ_catch
#  1 #_recruitments
#  1 #_parameter-priors
#  1 #_parameter-dev-vectors
#  1 #_crashPenLambda
#  0 # F_ballpark_lambda
0 # (0/1) read specs for more stddev reporting 
 # 0 1 -1 5 1 5 1 -1 5 # placeholder for selex type, len/age, year, N selex
#  bins, Growth pattern, N growth ages, NatAge_area(-1 for all), NatAge_yr,
#  N Natages
 # placeholder for vector of selex bins to be reported
 # placeholder for vector of growth ages to be reported
 # placeholder for vector of NatAges ages to be reported
999

