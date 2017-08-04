#V3.30.04.02
#_data_and_control_files: YTRK.South.data.ss // YTRK.South.control.ss
#_SS-V3.30.04.02-safe;_2017_05_31;_Stock_Synthesis_by_Richard_Methot_(NOAA)
# _using_ADMB_11.6
#_SS-V3.30.04.02-safe;user_support_available_at:NMFS.Stock.Synthesis@noaa.g
# ov
#_SS-V3.30.04.02-safe;user_info_available_at:https://vlab.ncep.noaa.gov/gro
# up/stock-synthesis
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and al
# so read and use growth parameters
1  #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)
#
2 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle t
# iming; 3=each Settle entity
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by 
# area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer
# ) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1
#  dest=2, age1=4, age2=10
#
3 #_Nblock_Patterns
 2 1 1 #_blocks_per_pattern 
# begin and end years of blocks
 1980 1989 1990 2016
 1999 2016
 1993 2016
#
# controls for all timevary parameters 
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to
#  base parm bounds; 3=no bound check)
#  autogen
1 1 1 1 1 # autogen
# where: 0 = autogen all time-varying parms; 1 = read each time-varying par
# m line; 2 = read then autogen if min=-12345
# 1st element for biology, 2nd for SR, 3rd for Q, 5th for selex, 4th reserv
# ed
#
# setup for M, growth, maturity, fecundity, recruitment distibution, moveme
# nt 
#
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agesp
# ec_withseasinterpolate
  #_no additional input for selected M option; read 1P per morph
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specifi
# c_K; 4=not implemented
1 #_Growth_Age_for_L1
25 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (fixed at 0.2 in 3.24; val
# ue should approx initial Z; -999 replicates 3.24)
0  #_placeholder for future growth feature
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
#
#_Females
#
#_LO    HI    INIT       PRIOR  PR_SD  PR_type  PHASE  env_var&link  dev_li
# nk  dev_minyr  dev_maxyr  dev_PH  Block  Block_Fxn
  0.02  0.25  0.174      -2.12  0.438  0        -2  0  0  0  0  0  0  0  # 
#  NatM_p_1_Fem_GP_1
  1     25    19.1511     22       99  0         3  0  0  0  0  0  0  0  # 
#  L_at_Amin_Fem_GP_1
  35    70    49.4756     55       99  0         2  0  0  0  0  0  0  0  # 
#  L_at_Amax_Fem_GP_1
  0.1   0.4   0.10909     0.1      99  0         3  0  0  0  0  0  0  0  # 
#  VonBert_K_Fem_GP_1
  0.03  0.16  0.0691595   0.1      99  0         5  0  0  0  0  0  0  0  # 
#  CV_young_Fem_GP_1
  0.03  0.16  0.0579808   0.1      99  0         5  0  0  0  0  0  0  0  # 
#  CV_old_Fem_GP_1
  0     3     1.1843e-005 99       99  0        -50 0  0  0  0  0  0  0  # 
#  Wtlen_1_Fem
  2     4     3.0672      99       99  0        -50 0  0  0  0  0  0  0  # 
#  Wtlen_2_Fem
  30    56    42.49       42.49    99  0        -50 0  0  0  0  0  0  0  # 
#  Mat50%_Fem
  -2    1    -0.40078    -0.40078  99  0        -50 0  0  0  0  0  0  0  # 
#  Mat_slope_Fem
  0     6     1.1185e-011 99       99  0        -50 0  0  0  0  0  0  0  # 
#  Eggs_scalar_Fem
  2     7     4.59        4.59     99  0        -50 0  0  0  0  0  0  0  # 
#  Eggs_exp_len_Fem
  #
  #_Males
  #
  -3    3    -0.149        0       99  6        -2  0  0  0  0  0  0  0  # 
#  NatM_p_1_Mal_GP_1
  -1    1     0            0       99  0        -2  0  0  0  0  0  0  0  # 
#  L_at_Amin_Mal_GP_1
  -1    1    -0.109466     0       99  0         2  0  0  0  0  0  0  0  # 
#  L_at_Amax_Mal_GP_1
  -1    1     0.0368187    0       99  0         3  0  0  0  0  0  0  0  # 
#  VonBert_K_Mal_GP_1
  -1    1     0            0       99  0        -5  0  0  0  0  0  0  0  # 
#  CV_young_Mal_GP_1
  -1    1     0.431753     0       99  0         5  0  0  0  0  0  0  0  # 
#  CV_old_Mal_GP_1
  0     3     1.1843e-005  99      99  0        -50 0  0  0  0  0  0  0  # 
#  Wtlen_1_Mal
  2     4     3.0672       99      99  0        -50 0  0  0  0  0  0  0  # 
#  Wtlen_2_Mal
  #
 #_Recruitment
 #
 0 2 1 1 99 0 -50 0 0 0 0 0 0 0 # RecrDist_GP_1
 0 2 1 1 99 0 -50 0 0 0 0 0 0 0 # RecrDist_Area_1
 0 2 1 1 99 0 -50 0 0 0 0 0 0 0 # RecrDist_month_1
 #
 1 1 1 1 1  0 -1  0 0 0 0 0 0 0 # CohortGrowDev
 #
 0.001 0.999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,m
# alewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
#_Spawner-Recruitment
3 #_SR_function: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=su
# rvival_3Parm; 8=Shepard_3Parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvatu
# re
#_LO HI   INIT    PRIOR  PR_SD  PR_type PHASE  env-var  use_dev   dev_mnyr 
#   dev_mxyr   dev_PH Block  Blk_Fxn #  parm_name
 8   12   9.90052   10 5  0       1        0   0   0   0   0   0   0 # SR_L
# N(R0)
 0.2  1   0.718     0.718 0.158   0       -6   0   0   0   0   0   0  0 # S
# R_BH_steep
 0.5  1.2 0.77      0.76  99 0   -6        0   0   0   0   0   0   0 # SR_s
# igmaR
-5    5   0         0     99 0   -50       0   0   0   0   0   0   0 # SR_r
# egime
 0    2   0         1     99 0   -50       0   0   0   0   0   0   0 # SR_a
# utocorr
#
1 #do_recdev:  0=none; 1=devvector; 2=simple deviations
1965 # first year of main recr_devs; early devs can preceed this era
2015 # last year of main recr_devs; forecast devs start in following year
#
4 #_recdev phase 
#
1 # (0/1) to read 13 advanced options
 1945 #_recdev_early_start (0=none; neg value makes relative to recdev_star
# t)
 5 #_recdev_early_phase
 5 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxpha
# se+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1965 #_last_early_yr_nobias_adj_in_MPD
 1972.2 #_first_yr_fullbias_adj_in_MPD
 2014.7 #_last_yr_fullbias_adj_in_MPD
 2016.1 #_first_recent_yr_nobias_adj_in_MPD
 0.7734 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for 
# all estimated recdevs)
#
 0 #_period of cycles in recruitment (N parms read below)
-6 #min rec_dev
 6 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#Fishing Mortality info 
#
0.3 # F ballpark
1984 # F ballpark year (neg value to disable)
1 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
0.95 # max F or harvest rate, depends on F_Method
#
#_Q_setup
#_fleet link link_info  extra_se   biasadj  float   #  fleetname
   1     1       0       1           0       0      #  RecreationalCatch
   3     1       0       1           0       1      #  Onboard_Early
   4     1       0       1           0       1      #  Onboard_Late
   5     1       0       1           0       1      #  HookAndLineSurvey
   6     1       0       1           0       1      #  JuvenilePelagic
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#
#_LO   HI      INIT      PRIOR   PR_SD PR_type   PHASE env-var use_dev   de
# v_mnyr   dev_mxyr  dev_PH   Block Blk_Fxn  #  parm_name
  -30   15   -11.9566    0 1 0  1 0 0 0 0 0 3 2  #  LnQ_base_RecreationalCa
# tch(1)
    0   0.5    0.465482  0 1 0  1 0 0 0 0 0 0 0  #  Q_extraSD_RecreationalC
# atch(1)
  -30   15   -10.9298    0 1 0  -1 0 0 0 0 0 0 0  #  LnQ_base_OnboardSurvey
# (3)
    0   0.5    0.465482  0 1 0  1 0 0 0 0 0 0 0  #  Q_extraSD_RecreationalC
# atch(1)
  -30   15   -10.9298    0 1 0  -1 0 0 0 0 0 0 0  #  LnQ_base_OnboardSurvey
# (4)
    0   0.5    0.465482  0 1 0  1 0 0 0 0 0 0 0  #  Q_extraSD_RecreationalC
# atch(1)
  -30   15   -12.5777    0 1 0 -1 0 0 0 0 0 0 0  #  LnQ_base_HookAndLineSur
# vey(5)
    0   0.5    0.465482  0 1 0  1 0 0 0 0 0 0 0  #  Q_extraSD_RecreationalC
# atch(1)
  -30   15    -8.6975    0 1 0 -1 0 0 0 0 0 0 0  #  LnQ_base_JuvenilePelagi
# c(6)
    0   0.5    0.465482  0 1 0  1 0 0 0 0 0 0 0  #  Q_extraSD_RecreationalC
# atch(1)
#
# timevary Q parameters 
#
#_LO   HI    INIT      PRIOR PR_SD  PR_type  PHASE  #  parm_name
  -30   15   -12.0538    0    1      0       1  # LnQ_base_RecreationalCatc
# h(1)_BLK3repl_1993
#
#_size_selex_types
#
#discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_
# discarded_dead
#
#_Pattern Discard Male Special
 24 0 0 0 # 1 RecreationalCatch
 24 0 0 0 # 2 CommercialCatch
 24 0 0 0 # 3 Onboard_Early
 24 0 0 0 # 4 Onboard_Late
 24 0 0 0 # 5 HookAndLineSurvey
  0 0 0 0 # 6 JuvenilePelagic
 24 0 0 0 # 7 SmallFish
#
#_age_selex_types
#
#_Pattern Discard Male Special
 10 0 0 0 # 1 RecreationalCatch
 10 0 0 0 # 2 CommercialCatch
 10 0 0 0 # 3 Onboard_Early
 10 0 0 0 # 4 Onboard_Late
 10 0 0 0 # 5 HookAndLineSurvey
 11 0 0 0 # 6 JuvenilePelagic
 10 0 0 0 # 7 SmallFish
#
#_LO   HI    INIT    PRIOR   PR_SD    PR_type   PHASE env-var use_dev   dev
# _mnyr   dev_mxyr  dev_PH   Block Blk_Fxn  #  parm_name
 20    55    33.1304   0   99    0    1    0    0    0    0    0    3    2 
 #  SizeSel_P1_RecreationalCatch(1)
-20    20    20        0   99    0   -4    0    0    0    0    0    0    0 
 #  SizeSel_P2_RecreationalCatch(1)
-5     20     3.77402  0   99    0    3    0    0    0    0    0    3    2 
 #  SizeSel_P3_RecreationalCatch(1)
-5     20    20        0   99    0   -4    0    0    0    0    0    0    0 
 #  SizeSel_P4_RecreationalCatch(1)
-999   25   -999       0   99    0  -99    0    0    0    0    0    0    0 
 #  SizeSel_P5_RecreationalCatch(1)
-999   25   -999       0   99    0  -99    0    0    0    0    0    0    0 
 #  SizeSel_P6_RecreationalCatch(1)
#
 20    55    35        0   99    0    1    0    0    0    0    0    0    0 
 #  SizeSel_P1_CommercialCatch(2)
-20    20    20        0   99    0   -4    0    0    0    0    0    0    0 
 #  SizeSel_P2_CommercialCatch(2)
-5     20     5.2539   0   99    0    3    0    0    0    0    0    0    0 
 #  SizeSel_P3_CommercialCatch(2)
-5     20    20        0   99    0   -4    0    0    0    0    0    0    0 
 #  SizeSel_P4_CommercialCatch(2)
-999   25   -999       0   99    0  -99    0    0    0    0    0    0    0 
 #  SizeSel_P5_CommercialCatch(2)
-999   25   -999       0   99    0  -99    0    0    0    0    0    0    0 
 #  SizeSel_P6_CommercialCatch(2)
#
 20    55    30.6644   0   99    0    1    0    0    0    0    0    0    0 
 #  SizeSel_P1_Onboard_Early(3)
-20     7   -20        0   99    0   -4    0    0    0    0    0    0    0 
 #  SizeSel_P2_Onboard_Early(3)
-5     20     3.3      0   99    0    3    0    0    0    0    0    0    0 
 #  SizeSel_P3_Onboard_Early(3)
-5     20    5         0   99    0    4    0    0    0    0    0    0    0 
 #  SizeSel_P4_Onboard_Early(3)
-999   25   -999       0   99    0  -99    0    0    0    0    0    0    0 
 #  SizeSel_P5_Onboard_Early(3)
-999   25   -999       0   99    0  -99    0    0    0    0    0    0    0 
 #  SizeSel_P6_Onboard_Early(3)
#
 20    55    30.6644   0   99    0    1    0    0    0    0    0    0    0 
 #  SizeSel_P1_Onboard_Late(4)
-20     7   -20        0   99    0   -4    0    0    0    0    0    0    0 
 #  SizeSel_P2_Onboard_Late(4)
-5     20     3.3      0   99    0    3    0    0    0    0    0    0    0 
 #  SizeSel_P3_Onboard_Late(4)
-5     20     5        0   99    0    4    0    0    0    0    0    0    0 
 #  SizeSel_P4_Onboard_Late(4)
-999   25   -999       0   99    0  -99    0    0    0    0    0    0    0 
 #  SizeSel_P5_Onboard_Late(4)
-999   25   -999       0   99    0  -99    0    0    0    0    0    0    0 
 #  SizeSel_P6_Onboard_Late(4)
#
 20    55    48.1678   0   99    0    1    0    0    0    0    0    0    0 
 #  SizeSel_P1_HookAndLineSurvey(5)
-20    20    20        0   99    0   -4    0    0    0    0    0    0    0 
 #  SizeSel_P2_HookAndLineSurvey(5)
-5     20     5.13638  0   99    0    3    0    0    0    0    0    0    0 
 #  SizeSel_P3_HookAndLineSurvey(5)
-5     20    20        0   99    0   -4    0    0    0    0    0    0    0 
 #  SizeSel_P4_HookAndLineSurvey(5)
-999   25   -999       0   99    0  -99    0    0    0    0    0    0    0 
 #  SizeSel_P5_HookAndLineSurvey(5)
-999   25   -999       0   99    0  -99    0    0    0    0    0    0    0 
 #  SizeSel_P6_HookAndLineSurvey(5)
#
 20    55    46.7886   0   99    0    1    0    0    0    0    0    0    0 
 #  SizeSel_P1_SmallFish(7)
-20    20    20        0   99    0   -4    0    0    0    0    0    0    0 
 #  SizeSel_P2_SmallFish(7)
-5     20     5.19586  0   99    0    3    0    0    0    0    0    0    0 
 #  SizeSel_P3_SmallFish(7)
-5     20    20        0   99    0   -4    0    0    0    0    0    0    0 
 #  SizeSel_P4_SmallFish(7)
-999   25   -999       0   99    0  -99    0    0    0    0    0    0    0 
 #  SizeSel_P5_SmallFish(7)
-999   25   -999       0   99    0  -99    0    0    0    0    0    0    0 
 #  SizeSel_P6_SmallFish(7)
#
#_Age_selex for Juvenile Pelagic Survey
#
 0     40     0        5   99    0   -1    0    0    0    0    0    0    0 
 #  AgeSel_P1_JuvenilePelagic(6)
 0     40     0        6   99    0   -1    0    0    0    0    0    0    0 
 #  AgeSel_P2_JuvenilePelagic(6)
# timevary selex parameters 
#_LO       HI          INIT    PRIOR    PR_SD  PR_type    PHASE  #  parm_na
# me
  20       55       29.9853        0       99        0      1    # SizeSel_
# P1_RecreationalCatch(1)_BLK3repl_1993
 -5        20       3.59529        0       99        0      3    # SizeSel_
# P3_RecreationalCatch(1)_BLK3repl_1993
#
#
0   #  use 2D_AR1 selectivity(0/1):  experimental feature
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#
#
#
#Factor Fleet New_Var_adj hash Old_Var_adj New_Francis New_MI Francis_mult 
# MI_mult Type Name Note
4 1 0.006896 # 0.01 0.006896 0.018571 0.68963 1.857066 len RecreationalCatc
# h 
4 2 0.39211 # 0.38 0.39211 0.495223 1.031869 1.303219 len CommercialCatch 
4 3 0.006977 # 0.01 0.006977 0.023855 0.697654 2.385539 len OnboardSurvey_E
# arly 
4 4 0.029389 # 0.03 0.029389 0.028288 0.979633 0.942943 len OnboardSurvey_L
# ate 
4 5 0.825847 # 0.83 0.825847 2.140478 0.994997 2.57889 len HookAndLineSurve
# y 
4 7 0.703572 # 0.71 0.703572 1.164502 0.990947 1.640144 len SmallFish 
5 2 0.096071 # 0.1 0.096071 0.215668 0.960714 2.156677 age CommercialCatch 
5 5 0.219381 # 0.22 NA 0.219381 NA 0.997185 age HookAndLineSurvey No Franci
# s weight--using MI value
5 7 0.080067 # 0.08 0.080067 0.330671 1.000835 4.133385 age SmallFish 
#
#
-9999   1    0  # terminator
#
5 #_maxlambdaphase
1 #_sd_offset
# read 1 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=
# sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag
# -comp; 16=Tag-negbin; 17=F_ballpark
#like_comp fleet  phase  value  sizefreq_method
 17 1 5 0 0
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  1 1 1 1 1 #_CPUE/survey:_1
#  0 0 0 0 0 #_CPUE/survey:_2
#  1 1 1 1 1 #_CPUE/survey:_3
#  1 1 1 1 1 #_CPUE/survey:_4
#  1 1 1 1 1 #_CPUE/survey:_5
#  0 0 0 0 0 #_CPUE/survey:_6
#  1 1 1 1 1 #_lencomp:_1
#  1 1 1 1 1 #_lencomp:_2
#  1 1 1 1 1 #_lencomp:_3
#  1 1 1 1 1 #_lencomp:_4
#  0 0 0 0 0 #_lencomp:_5
#  1 1 1 1 1 #_lencomp:_6
#  0 0 0 0 0 #_agecomp:_1
#  1 1 1 1 1 #_agecomp:_2
#  0 0 0 0 0 #_agecomp:_3
#  1 1 1 1 1 #_agecomp:_4
#  0 0 0 0 0 #_agecomp:_5
#  1 1 1 1 1 #_agecomp:_6
#  1 1 1 1 1 #_init_equ_catch
#  1 1 1 1 1 #_recruitments
#  1 1 1 1 1 #_parameter-priors
#  1 1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 1 #_crashPenLambda
#  1 1 1 1 0 # F_ballpark_lambda
0 # (0/1) read specs for more stddev reporting 
#
999
