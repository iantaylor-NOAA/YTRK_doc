#V3.30.03.07-trans
#C China rockfish control file for north model (WA only)
#_data_and_control_files: china_WAonly_data.ss // china_WAonly_control.ss
#_SS-V3.30.03.07-trans;_2017_05_19;_Stock_Synthesis_by_Richard_Methot_(NOAA
# )_using_ADMB_11.6
#_SS-V3.30.03.07-trans;user_support_available_at:NMFS.Stock.Synthesis@noaa.
# gov
#_SS-V3.30.03.07-trans;user_info_available_at:https://vlab.ncep.noaa.gov/gr
# oup/stock-synthesis
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and al
# so read and use growth parameters
1  #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)
#
1 # recr_dist_method for parameters:  1=like 3.24; 2=main effects for GP, S
# ettle timing, Area; 3=each Settle entity; 4=none when N_GP*Nsettle*pop==1
1 # Recruitment: 1=global; 2=by area (future option)
1 #  number of recruitment settlement assignments 
0 # year_x_area_x_settlement_event interaction requested (only for recr_dis
# t_method=1)
#GPat month  area age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer
# ) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1
#  dest=2, age1=4, age2=10
#
1 #_Nblock_Patterns
 1 #_blocks_per_pattern 
# begin and end years of blocks
 1899 1899
#
# controls for all timevary parameters 
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to
#  base parm bounds; 3=no bound check)
#  autogen
0 0 0 0 0 # autogen
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
0 #_Growth_Age_for_L1
30 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (fixed at 0.2 in 3.24; val
# ue should approx initial Z; -999 replicates 3.24)
0  #_placeholder for future growth feature
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 l
# ogSD=F(A)
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturit
# y matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read leng
# th-maturity
1 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)e
# ggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=
# male-to-female age-specific fxn
2 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-
# GP1, 3=like SS2 V1.x)
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev
# _maxyr dev_PH Block Block_Fxn
 0.01 0.15 0.07 -2.94 0.53 3 -3 0 0 0 0 0 0 0 # NatM_p_1_Fem_GP_1
 -10 45 2 2 10 6 -2 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 20 50 34 34 10 6 6 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.01 0.3 0.1 0.1 0.8 6 6 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0.01 0.25 0.1 0.1 0.8 0 -6 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.01 0.25 0.1 0.1 0.8 0 6 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
 0 1 1.17e-005 1.17e-005 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_1_Fem
 2 4 3.177 3 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_2_Fem
 1 100 28.5 28.5 0.8 0 -3 0 0 0 0 0 0 0 # Mat50%_Fem
 -9 9 -1 0 0.8 0 -3 0 0 0 0 0 0 0 # Mat_slope_Fem
 -3 3 0.196 1 0.8 0 -3 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem
 -3 3 0.0571 0 0.8 0 -3 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem
 -1 0.15 0 0.053 0.8 0 -3 0 0 0 0 0 0 0 # NatM_p_1_Mal_GP_1
 -1 45 0 2 10 6 -2 0 0 0 0 0 0 0 # L_at_Amin_Mal_GP_1
 -1 50 0 33.13 10 6 -4 0 0 0 0 0 0 0 # L_at_Amax_Mal_GP_1
 -1 0.3 0 0.2461 0.8 6 -4 0 0 0 0 0 0 0 # VonBert_K_Mal_GP_1
 -1 0.25 0 0.1 0.8 0 -3 0 0 0 0 0 0 0 # CV_young_Mal_GP_1
 -1 0.25 0 0.1 0.8 0 -3 0 0 0 0 0 0 0 # CV_old_Mal_GP_1
 0 1 1.17e-005 1.17e-005 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_1_Mal
 2 4 3.177 3 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_2_Mal
 0 0 0 0 0 0 -4 0 0 0 0 0 0 0 # RecrDist_GP_1
 0 0 0 0 0 0 -4 0 0 0 0 0 0 0 # RecrDist_Area_1
 0 0 0 0 0 0 -4 0 0 0 0 0 0 0 # RecrDist_Bseas_1
 0 0 0 0 0 0 -4 0 0 0 0 0 0 0 # CohortGrowDev
 0.000001 0.999999 0.5 0.5  0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
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
#_          LO            HI          INIT         PRIOR         PR_SD     
#   PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_
# PH      Block    Blk_Fxn #  parm_name
             2            12           2.7             6            10     
        0          1          0          0          0          0          0
          0          0 # SR_LN(R0)
           0.2             1         0.773         0.773         0.147     
        2         -3          0          0          0          0          0
          0          0 # SR_BH_steep
             0             2           0.5           0.5           0.8     
        0         -3          0          0          0          0          0
          0          0 # SR_sigmaR
            -5             5             0             0             1     
        0         -4          0          0          0          0          0
          0          0 # SR_regime
             0             0             0             0             0     
        0        -99          0          0          0          0          0
          0          0 # SR_autocorr
0 #do_recdev:  0=none; 1=devvector; 2=simple deviations
1971 # first year of main recr_devs; early devs can preceed this era
2001 # last year of main recr_devs; forecast devs start in following year
-2 #_recdev phase 
1 # (0/1) to read 13 advanced options
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -4 #_recdev_early_phase
 -4 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxph
# ase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1980 #_last_early_yr_nobias_adj_in_MPD
 1985 #_first_yr_fullbias_adj_in_MPD
 2001 #_last_yr_fullbias_adj_in_MPD
 2015 #_first_recent_yr_nobias_adj_in_MPD
 1 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all e
# stimated recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  2002F 2003F 2004F 2005F 2006F 2007F 2008F 2009F 2010F 2011F 2012F 2013F 
# 2014F 2015F 2016F 2017F 2018F 2019F 2020F 2021F 2022F 2023F 2024F 2025F 2
# 026F
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# implementation error by year in forecast:  0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.3 # F ballpark
-2001 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
2.9 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed input
# s to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
5  # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms; count = 0
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#2026 2015
# F rates by fleet
# Yr:  1900 1901 1902 1903 1904 1905 1906 1907 1908 1909 1910 1911 1912 191
# 3 1914 1915 1916 1917 1918 1919 1920 1921 1922 1923 1924 1925 1926 1927 1
# 928 1929 1930 1931 1932 1933 1934 1935 1936 1937 1938 1939 1940 1941 1942
#  1943 1944 1945 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 19
# 57 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 
# 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 198
# 6 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2
# 001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015
#  2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 
# 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 
# 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# 1_WA_SouthernWA_Rec_PCPR 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
# 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#  0 0 0 0 0 0 0 0.000447812 0.000919226 0.00142128 0.00196226 0.0025517 0.
# 00293448 0.00364452 0.00444408 0.000617426 0.00031448 0.00196121 0.000345
# 465 0.000719766 0.00222999 0.00192191 0 0.00462514 0.00266008 0.00754233 
# 0.0102796 0.0139661 0.0186883 0.0273859 0.0250309 0.0483753 0.0627616 0.0
# 834237 0.0315798 0.0414022 0.065793 0.0855864 0.0184711 0.0301325 0.07804
# 17 0.0286498 0.0278454 0.0359339 0.00890704 0.00897722 0.0217709 0.058722
# 7 0.027316 0.0897656 0.0428736 0.0617923 0.0706869 0.0538975 0.0305592 0.
# 0305093 -4.4305e-005 -5.7557e-005 -8.55916e-005 -0.000128536 -0.000136188
# 2_WA_NorthernWA_Rec_PC 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
# 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#  0 0 0 0 0 0.00542495 0.00656886 0.00779064 0.00932542 0.0107686 0.012355
# 3 0.0143592 0.0163417 0.018583 0.0106448 0.00826468 0.0230643 0.0193314 0
# .0171796 0.0157043 0.0193153 0.0222364 0.0251659 0.026862 0.0326663 0.046
# 8513 0.0655581 0.0930715 0.136411 0.0472525 0.169135 0.181228 0.245487 0.
# 148338 0.120123 0.106711 0.0203026 0.0214398 0.0958455 0.0605645 0.056875
# 8 0.0289617 0.0328674 0.0444298 0.0189282 0.036978 0.0847346 0.0522517 0.
# 0478775 0.0796843 0.144873 0.200001 0.289338 0.204906 0.214725 -0.0001057
# 95 -0.000137439 -0.000204383 -0.000306929 -0.000325202 0.000125557 0.0010
# 3_WA_NorthernWA_Rec_PR 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
# 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#  0 0 0 0 0 0.0208961 0.0256596 0.0305309 0.0360005 0.0419528 0.0484886 0.
# 055733 0.0635794 0.0727162 0.0414585 0.0319188 0.0893004 0.0748311 0.0661
# 253 0.0611466 0.0751916 0.0867937 0.0984101 0.104288 0.126477 0.169665 0.
# 227917 0.31185 0.448099 0.331694 0.673066 0.814724 0.674048 0.848 0.61129
# 1 0.568236 0.418742 0.559816 0.586762 0.758268 0.53661 0.526138 0.462491 
# 0.57525 0.520525 0.672999 0.732545 0.783776 1.23745 1.41557 1.52406 2.266
# 67 2.58665 1.8981 1.94328 -0.00125414 -0.00162927 -0.00242285 -0.00363848
#  -0.00385509 0.00148841 0.0126135 0.0227104 0.029715 0.0345035
#
#_Q_setup
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         3         1         0         1         1         1  #  3_WA_North
# ernWA_Rec_PR
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD     
#   PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_
# PH      Block    Blk_Fxn  #  parm_name
           -15            15      -2.74264             0             1     
        0         -1          0          0          0          0          0
          0          0  #  LnQ_base_3_WA_NorthernWA_Rec_PR(3)
             0             2          0.15             1            99     
        0          2          0          0          0          0          0
          0          0  #  Q_extraSD_3_WA_NorthernWA_Rec_PR(3)
#_no timevary Q parameters
#
#_size_selex_types
#discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_
# discarded_dead
#_Pattern Discard Male Special
 24 0 0 0 # 1 1_WA_SouthernWA_Rec_PCPR
 24 0 0 0 # 2 2_WA_NorthernWA_Rec_PC
 15 0 0 2 # 3 3_WA_NorthernWA_Rec_PR
#
#_age_selex_types
#_Pattern Discard Male Special
 10 0 0 0 # 1 1_WA_SouthernWA_Rec_PCPR
 10 0 0 0 # 2 2_WA_NorthernWA_Rec_PC
 10 0 0 0 # 3 3_WA_NorthernWA_Rec_PR
#
#_          LO            HI          INIT         PRIOR         PR_SD     
#   PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_
# PH      Block    Blk_Fxn  #  parm_name
            19            36         34.89            30            50     
        0         -4          0          0          0          0          0
          0          0  #  SizeSel_P1_1_WA_SouthernWA_Rec_PCPR(1)
            -9             5            -4            -4            50     
        0         -9          0          0          0          0          0
          0          0  #  SizeSel_P2_1_WA_SouthernWA_Rec_PCPR(1)
             0             9             3             4            50     
        0          5          0          0          0          0          0
          0          0  #  SizeSel_P3_1_WA_SouthernWA_Rec_PCPR(1)
             0             9             8             8            50     
        0         -9          0          0          0          0          0
          0          0  #  SizeSel_P4_1_WA_SouthernWA_Rec_PCPR(1)
            -9             9            -8            -5            50     
        0         -9          0          0          0          0          0
          0          0  #  SizeSel_P5_1_WA_SouthernWA_Rec_PCPR(1)
            -9             9             8             5            50     
        0         -9          0          0          0          0          0
          0          0  #  SizeSel_P6_1_WA_SouthernWA_Rec_PCPR(1)
            19            36            34            30            50     
        0          4          0          0          0          0          0
          0          0  #  SizeSel_P1_2_WA_NorthernWA_Rec_PC(2)
            -9             5            -4            -4            50     
        0         -9          0          0          0          0          0
          0          0  #  SizeSel_P2_2_WA_NorthernWA_Rec_PC(2)
             0             9             3             4            50     
        0          5          0          0          0          0          0
          0          0  #  SizeSel_P3_2_WA_NorthernWA_Rec_PC(2)
             0             9             8             8            50     
        0         -9          0          0          0          0          0
          0          0  #  SizeSel_P4_2_WA_NorthernWA_Rec_PC(2)
            -9             9            -8            -5            50     
        0         -9          0          0          0          0          0
          0          0  #  SizeSel_P5_2_WA_NorthernWA_Rec_PC(2)
            -9             9             8             5            50     
        0         -9          0          0          0          0          0
          0          0  #  SizeSel_P6_2_WA_NorthernWA_Rec_PC(2)
#_no timevary selex parameters
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
      4      1     0.189
      4      3     0.089
      5      3    0.2428
 -9999   1    0  # terminator
#
4 #_maxlambdaphase
1 #_sd_offset
# read 0 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=
# sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag
# -comp; 16=Tag-negbin; 17=F_ballpark
#like_comp fleet  phase  value  sizefreq_method
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 0 0 0 #_CPUE/survey:_1
#  0 0 0 0 #_CPUE/survey:_2
#  1 1 1 1 #_CPUE/survey:_3
#  1 1 1 1 #_lencomp:_1
#  0 0 0 0 #_lencomp:_2
#  1 1 1 1 #_lencomp:_3
#  1 1 1 1 #_agecomp:_1
#  0 0 0 0 #_agecomp:_2
#  1 1 1 1 #_agecomp:_3
#  1 1 1 1 #_init_equ_catch
#  1 1 1 1 #_recruitments
#  1 1 1 1 #_parameter-priors
#  1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 #_crashPenLambda
#  0 0 0 0 # F_ballpark_lambda
0 # (0/1) read specs for more stddev reporting 
 # 0 1 -1 5 1 5 1 -1 5 # placeholder for selex type, len/age, year, N selex
#  bins, Growth pattern, N growth ages, NatAge_area(-1 for all), NatAge_yr,
#  N Natages
 # placeholder for vector of selex bins to be reported
 # placeholder for vector of growth ages to be reported
 # placeholder for vector of NatAges ages to be reported
999

