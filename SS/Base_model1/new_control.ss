#V3.30.03.07
#_data_and_control_files: YTRK.North.data.ss // YTRK.North.control.ss
#_SS-V3.30.03.07-safe;_2017_05_19;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_11.6
#_SS-V3.30.03.07-safe;user_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_SS-V3.30.03.07-safe;user_info_available_at:https://vlab.ncep.noaa.gov/group/stock-synthesis
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)
#
1 # recr_dist_method for parameters:  1=like 3.24; 2=main effects for GP, Settle timing, Area; 3=each Settle entity; 4=none when N_GP*Nsettle*pop==1
1 # Recruitment: 1=global; 2=by area (future option)
1 #  number of recruitment settlement assignments 
0 # year_x_area_x_settlement_event interaction requested (only for recr_dist_method=1)
#GPat month  area age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
1 #_Nblock_Patterns
 2 #_blocks_per_pattern 
# begin and end years of blocks
 2002 2010 2011 2017
#
# controls for all timevary parameters 
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to base parm bounds; 3=no bound check)
#  autogen
1 1 1 1 1 # autogen
# where: 0 = autogen all time-varying parms; 1 = read each time-varying parm line; 2 = read then autogen if min=-12345
# 1st element for biology, 2nd for SR, 3rd for Q, 5th for selex, 4th reserved
#
# setup for M, growth, maturity, fecundity, recruitment distibution, movement 
#
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
  #_no additional input for selected M option; read 1P per morph
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K; 4=not implemented
0 #_Growth_Age_for_L1
25 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (fixed at 0.2 in 3.24; value should approx initial Z; -999 replicates 3.24)
0  #_placeholder for future growth feature
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
5 #_First_Mature_Age
2 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
2 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
 0.02 0.25 0.12 -2.12 0.438 0 -2 0 0 0 0 0 0 0 # NatM_p_1_Fem_GP_1
 1 25 1 22 99 0 3 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 35 70 54.334 55 99 0 2 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.1 0.4 0.142793 0.1 99 0 3 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0.03 0.16 0.03 0.1 99 0 5 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.03 0.16 0.0698574 0.1 99 0 5 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
 0 3 1.1843e-005 99 99 0 -50 0 0 0 0 0 0 0 # Wtlen_1_Fem
 2 4 3.0672 99 99 0 -50 0 0 0 0 0 0 0 # Wtlen_2_Fem
 30 56 42.49 42.49 99 0 -50 0 0 0 0 0 0 0 # Mat50%_Fem
 -2 1 -0.40078 -0.40078 99 0 -50 0 0 0 0 0 0 0 # Mat_slope_Fem
 0 6 2.88e-005 2.88e-005 99 0 -50 0 0 0 0 0 0 0 # Eggs_scalar_Fem
 2 7 4.59 4.59 99 0 -50 0 0 0 0 0 0 0 # Eggs_exp_len_Fem
 -3 3 0 0 99 6 -2 0 0 0 0 0 0 0 # NatM_p_1_Mal_GP_1
 -1 1 0 0 99 0 -2 0 0 0 0 0 0 0 # L_at_Amin_Mal_GP_1
 -1 1 -0.150036 0 99 0 2 0 0 0 0 0 0 0 # L_at_Amax_Mal_GP_1
 -1 1 0.294116 0 99 0 3 0 0 0 0 0 0 0 # VonBert_K_Mal_GP_1
 -1 1 0 0 99 0 -5 0 0 0 0 0 0 0 # CV_young_Mal_GP_1
 -1 1 -0.205374 0 99 0 5 0 0 0 0 0 0 0 # CV_old_Mal_GP_1
 0 3 1.1843e-005 99 99 0 -50 0 0 0 0 0 0 0 # Wtlen_1_Mal
 2 4 3.0672 99 99 0 -50 0 0 0 0 0 0 0 # Wtlen_2_Mal
 0 2 1 1 99 0 -50 0 0 0 0 0 0 0 # RecrDist_GP_1
 0 2 1 1 99 0 -50 0 0 0 0 0 0 0 # RecrDist_Area_1
 0 2 1 1 99 0 -50 0 0 0 0 0 0 0 # RecrDist_Bseas_1
 0 2 1 1 99 0 -50 0 0 0 0 0 0 0 # CohortGrowDev
 0.001 0.999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
#_Spawner-Recruitment
3 #_SR_function: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepard_3Parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
             5            20       10.1586            10             5             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
           0.2             1         0.718         0.718         0.158             0         -6          0          0          0          0          0          0          0 # SR_BH_steep
           0.5           1.2           0.7          0.76            99             0         -6          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0            99             0        -50          0          0          0          0          0          0          0 # SR_regime
             0             2             0             1            99             0        -50          0          0          0          0          0          0          0 # SR_autocorr
1 #do_recdev:  0=none; 1=devvector; 2=simple deviations
1975 # first year of main recr_devs; early devs can preceed this era
2014 # last year of main recr_devs; forecast devs start in following year
4 #_recdev phase 
1 # (0/1) to read 13 advanced options
 1932 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -5 #_recdev_early_phase
 5 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1954 #_last_early_yr_nobias_adj_in_MPD
 1970 #_first_yr_fullbias_adj_in_MPD
 2006 #_last_yr_fullbias_adj_in_MPD
 2009 #_first_recent_yr_nobias_adj_in_MPD
 0.875 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -6 #min rec_dev
 6 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1932E 1933E 1934E 1935E 1936E 1937E 1938E 1939E 1940E 1941E 1942E 1943E 1944E 1945E 1946E 1947E 1948E 1949E 1950E 1951E 1952E 1953E 1954E 1955E 1956E 1957E 1958E 1959E 1960E 1961E 1962E 1963E 1964E 1965E 1966E 1967E 1968E 1969E 1970E 1971E 1972E 1973E 1974E 1975R 1976R 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015F 2016F 2017F 2018F 2019F 2020F 2021F 2022F 2023F 2024F 2025F 2026F 2027F 2028F
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.931679 0.659677 0.280141 0.0136691 -0.248282 0.0399104 -0.0501467 -0.462347 -0.0215284 0.0330689 -0.250208 -0.148473 0.0383711 -0.219995 0.104089 0.490657 0.303407 -0.139787 -0.258753 -0.0332111 -0.362173 -0.418803 -0.386209 1.88767 -1.58833 -0.528353 0.0960568 2.69542 0.186052 2.49795 1.09034 0.800316 -1.06039 -0.748792 -1.16375 -0.851389 -1.38648 -1.024 -0.600213 -0.196865 -0.000372618 0 0 0 0 0 0 0 0 0 0 0 0 0
# implementation error by year in forecast:  0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.03 # F ballpark
-1999 # F ballpark year (neg value to disable)
1 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
0.95 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed inputs to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
#
#_initial_F_parms; count = 0
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#2028 2037
# F rates by fleet
# Yr:  1889 1890 1891 1892 1893 1894 1895 1896 1897 1898 1899 1900 1901 1902 1903 1904 1905 1906 1907 1908 1909 1910 1911 1912 1913 1914 1915 1916 1917 1918 1919 1920 1921 1922 1923 1924 1925 1926 1927 1928 1929 1930 1931 1932 1933 1934 1935 1936 1937 1938 1939 1940 1941 1942 1943 1944 1945 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# CommercialTrawl 1.2718e-006 1.36963e-006 2.44577e-006 2.31964e-005 2.03597e-005 2.03599e-005 5.52902e-006 1.26036e-006 1.28466e-006 7.27123e-007 1.22985e-006 1.73257e-006 2.2352e-006 2.73791e-006 3.24063e-006 6.4827e-006 4.24599e-006 4.74871e-006 5.25144e-006 7.22159e-006 6.25682e-006 6.75955e-006 7.26229e-006 7.76494e-006 8.26769e-006 8.77044e-006 1.02515e-005 1.05673e-005 1.15114e-005 3.81514e-005 2.10806e-005 1.9845e-005 1.96875e-005 1.68451e-005 1.83842e-005 2.50375e-005 2.89091e-005 3.8929e-005 4.73824e-005 5.39092e-005 0.000111424 0.000153525 9.96788e-005 2.92831e-005 4.04042e-005 6.75831e-005 9.43094e-005 0.000134887 0.00024963 0.000278295 0.000358306 0.00128015 0.00170597 0.00296714 0.012804 0.0217198 0.0402082 0.0229249 0.0130958 0.0110418 0.00577196 0.0122126 0.0121082 0.0162075 0.00889841 0.0116569 0.0121705 0.0141689 0.014428 0.0148917 0.0156418 0.0192086 0.0182028 0.0245768 0.0200879 0.0164798 0.0156368 0.0121246 0.014735 0.0211944 0.0360837 0.0166665 0.0174225 0.0261896 0.031479 0.0228205 0.0163462 0.0456565 0.0702506 0.101692 0.0949339 0.094308 0.123952 0.132537 0.146431 0.0792868 0.05331 0.0763718 0.079705 0.108902 0.0911434 0.0877207 0.0776194 0.123645 0.126381 0.130697 0.12227 0.138129 0.0505174 0.0664359 0.0588867 0.0767124 0.0509732 0.0266258 0.00922635 0.0114825 0.0140425 0.00608318 0.00361268 0.0030241 0.00466916 0.00552112 0.00757967 0.00890788 0.0062779 0.00751883 0.0101604 0.00742466 0.0569955 0.0569955 0.0569955 nan nan nan nan nan nan nan nan nan
# HakeByCatch 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000575535 0.000148544 0.00157089 0.0018277 0.00603791 0.00381781 0.0148275 0.0158279 0.00961497 0.0053236 0.0166428 0.0161918 0.0129633 0.006002 0.0100848 0.0172482 0.0263619 0.0114068 0.0253784 0.0318435 0.0393292 0.0224114 0.0239432 0.0633091 0.0326939 0.0107402 0.00916947 0.00168654 0.00207331 0.00459028 0.00407238 0.00261832 0.00510452 0.00443493 0.00315618 0.00172306 0.000589888 0.00304209 0.000408088 0.000761331 0.000525254 0.00403212 0.00403212 0.00403212 0.00403212 nan nan nan nan nan nan nan nan
# RecORandCA 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000239332 0.000236573 0.00094995 0.000993291 0.0018909 0.000627746 0.0033427 0.000532346 0.000461603 0.000360143 0.00089537 0.000846981 0.00121511 0.0047554 0.00439937 0.00199631 0.00158433 0.00146264 0.00193047 0.00176827 0.00115553 0.000723648 0.000705183 0.000605095 0.000367847 0.000325065 0.000436769 0.00027756 0.0001578 0.000168556 9.95086e-005 6.38424e-005 0.000101684 0.000116268 0.000126387 0.000109122 0.000222699 0.000119406 0.000916622 0.000916622 0.000916622 0.000916622 nan nan nan nan nan nan nan nan
# RecWA 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00070852 0 0 0 0 0 0 0 0.000233428 0.000310467 0.000158039 0.000265173 8.55101e-005 6.61136e-005 9.01782e-005 4.69608e-005 7.43106e-005 7.96775e-005 0.000135964 0.000248072 0.000458726 0.000479622 0.000512315 0.000469925 0.00105015 0.0011578 0.00162273 0.000728987 0.000631435 0.000862394 0.000892412 0.0012993 0.00046865 0.000555113 0.000383828 0.00016153 0.000400579 0.00071567 0.0005703 0.000340358 0.000303105 0.000298239 0.000386108 0.000450435 0.000456151 0.000188044 0.000230001 0.000315477 0.000586429 0.00079592 0.0061099 0.0061099 0.0061099 0.0061099 nan nan nan nan nan nan nan nan
#
#_Q_setup
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         1         1         0         0         0         1  #  CommercialTrawl
         2         1         0         0         0         1  #  HakeByCatch
         5         1         0         0         0         1  #  Triennial
         6         1         0         0         0         1  #  NWFSCcombo
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -30            15      -4.89312             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_CommercialTrawl(1)
           -30            15      -10.2568             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_HakeByCatch(2)
           -30            15      -2.13414             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_Triennial(5)
           -30            15      -1.03652             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_NWFSCcombo(6)
#_no timevary Q parameters
#
#_size_selex_types
#discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead
#_Pattern Discard Male Special
 24 1 0 0 # 1 CommercialTrawl
 24 0 0 0 # 2 HakeByCatch
 24 0 0 0 # 3 RecORandCA
 24 0 0 0 # 4 RecWA
 24 0 0 0 # 5 Triennial
 24 0 0 0 # 6 NWFSCcombo
#
#_age_selex_types
#_Pattern Discard Male Special
 10 0 0 0 # 1 CommercialTrawl
 10 0 0 0 # 2 HakeByCatch
 10 0 0 0 # 3 RecORandCA
 10 0 0 0 # 4 RecWA
 10 0 0 0 # 5 Triennial
 10 0 0 0 # 6 NWFSCcombo
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
            20            55            55             0            99             0          1          0          0          0          0          0          0          0  #  SizeSel_P1_CommercialTrawl(1)
           -20             7       6.96542             0            99             0          4          0          0          0          0          0          0          0  #  SizeSel_P2_CommercialTrawl(1)
            -5            20       6.20005             0            99             0          3          0          0          0          0          0          0          0  #  SizeSel_P3_CommercialTrawl(1)
            -5            20      -2.00782             0            99             0          4          0          0          0          0          0          0          0  #  SizeSel_P4_CommercialTrawl(1)
          -999            25          -999             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P5_CommercialTrawl(1)
          -999            25          -999             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P6_CommercialTrawl(1)
            20            55       29.0706            27            99             0          3          0          0          0          0          0          0          0  #  Retain_P1_CommercialTrawl(1)
           0.1            40           0.1            15            99             0          3          0          0          0          0          0          0          0  #  Retain_P2_CommercialTrawl(1)
           -10            20       3.94472             3            99             0          3          0          0          0          0          0          1          2  #  Retain_P3_CommercialTrawl(1)
            -3             3             0             0             3             0         -4          0          0          0          0          0          0          0  #  Retain_P4_CommercialTrawl(1)
            20            55       51.4119             0            99             0          1          0          0          0          0          0          0          0  #  SizeSel_P1_HakeByCatch(2)
           -20             7      -10.8687             0            99             0          4          0          0          0          0          0          0          0  #  SizeSel_P2_HakeByCatch(2)
            -5            20       4.03565             0            99             0          3          0          0          0          0          0          0          0  #  SizeSel_P3_HakeByCatch(2)
            -5            20       1.79521             0            99             0          4          0          0          0          0          0          0          0  #  SizeSel_P4_HakeByCatch(2)
          -999            25          -999             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P5_HakeByCatch(2)
          -999            25          -999             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P6_HakeByCatch(2)
            20            55       30.9156             0            99             0          1          0          0          0          0          0          0          0  #  SizeSel_P1_RecORandCA(3)
           -20             7      -19.7989             0            99             0          4          0          0          0          0          0          0          0  #  SizeSel_P2_RecORandCA(3)
            -5            20       3.14529             0            99             0          3          0          0          0          0          0          0          0  #  SizeSel_P3_RecORandCA(3)
            -5            20        5.7754             0            99             0          4          0          0          0          0          0          0          0  #  SizeSel_P4_RecORandCA(3)
          -999            25          -999             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P5_RecORandCA(3)
          -999            25          -999             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P6_RecORandCA(3)
            20            55            55             0            99             0          1          0          0          0          0          0          0          0  #  SizeSel_P1_RecWA(4)
           -20             7       2.18416             0            99             0          4          0          0          0          0          0          0          0  #  SizeSel_P2_RecWA(4)
            -5            20       5.47746             0            99             0          3          0          0          0          0          0          0          0  #  SizeSel_P3_RecWA(4)
            -5            20       18.9169             0            99             0          4          0          0          0          0          0          0          0  #  SizeSel_P4_RecWA(4)
          -999            25          -999             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P5_RecWA(4)
          -999            25          -999             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P6_RecWA(4)
            20            55       21.4176             0            99             0          1          0          0          0          0          0          0          0  #  SizeSel_P1_Triennial(5)
           -20             7       1.88352             0            99             0          4          0          0          0          0          0          0          0  #  SizeSel_P2_Triennial(5)
            -5            20            -5             0            99             0          3          0          0          0          0          0          0          0  #  SizeSel_P3_Triennial(5)
            -5            20        1.5809             0            99             0          4          0          0          0          0          0          0          0  #  SizeSel_P4_Triennial(5)
          -999            25          -999             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P5_Triennial(5)
          -999            25          -999             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P6_Triennial(5)
            20            55            55             0            99             0          1          0          0          0          0          0          0          0  #  SizeSel_P1_NWFSCcombo(6)
           -20             7       2.19256             0            99             0          4          0          0          0          0          0          0          0  #  SizeSel_P2_NWFSCcombo(6)
            -5            20       5.21277             0            99             0          3          0          0          0          0          0          0          0  #  SizeSel_P3_NWFSCcombo(6)
            -5            20       18.4694             0            99             0          4          0          0          0          0          0          0          0  #  SizeSel_P4_NWFSCcombo(6)
          -999            25          -999             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P5_NWFSCcombo(6)
          -999            25          -999             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P6_NWFSCcombo(6)
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
           -10            20        5.1871             3            99             0      3  # Retain_P3_CommercialTrawl(1)_BLK1repl_2002
           -10            20       19.9974             3            99             0      3  # Retain_P3_CommercialTrawl(1)_BLK1repl_2011
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity(0/1):  experimental feature
#_no 2D_AR1 selex offset used
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      5     9     1     1     2     0     0     0     0     0     0     0
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
 #_Factor Fleet     Var_Adj
        4     1 0.013943809
        4     2 0.028889631
        4     3 0.035189219
        4     4 0.004521006
        4     5 0.059357668
        4     6 0.008537384
        5     1 0.027288670
        5     2 0.010000000
        5     3 0.010000000
        5     4 0.028359924
        5     5 0.019423449
        5     6 0.194267171
    -9999     1 0.000000000
#
1 #_maxlambdaphase
1 #_sd_offset
# read 0 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark
#like_comp fleet  phase  value  sizefreq_method
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  1 #_CPUE/survey:_1
#  1 #_CPUE/survey:_2
#  0 #_CPUE/survey:_3
#  0 #_CPUE/survey:_4
#  1 #_CPUE/survey:_5
#  1 #_CPUE/survey:_6
#  1 #_discard:_1
#  0 #_discard:_2
#  0 #_discard:_3
#  0 #_discard:_4
#  0 #_discard:_5
#  0 #_discard:_6
#  1 #_lencomp:_1
#  1 #_lencomp:_2
#  1 #_lencomp:_3
#  1 #_lencomp:_4
#  1 #_lencomp:_5
#  1 #_lencomp:_6
#  1 #_agecomp:_1
#  0 #_agecomp:_2
#  0 #_agecomp:_3
#  1 #_agecomp:_4
#  1 #_agecomp:_5
#  1 #_agecomp:_6
#  1 #_init_equ_catch
#  1 #_recruitments
#  1 #_parameter-priors
#  1 #_parameter-dev-vectors
#  1 #_crashPenLambda
#  0 # F_ballpark_lambda
0 # (0/1) read specs for more stddev reporting 
 # 0 1 -1 5 1 5 1 -1 5 # placeholder for selex type, len/age, year, N selex bins, Growth pattern, N growth ages, NatAge_area(-1 for all), NatAge_yr, N Natages
 # placeholder for vector of selex bins to be reported
 # placeholder for vector of growth ages to be reported
 # placeholder for vector of NatAges ages to be reported
999

