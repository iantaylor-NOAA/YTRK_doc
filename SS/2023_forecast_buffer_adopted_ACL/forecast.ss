#Yellowtail forecast file 3.30.03.07
# for all year entries except rebuilder; enter either: actual year, -999 for styr, 0 for endyr, neg number for rel. endyr
1 # Benchmarks: 0=skip; 1=calc F_spr,F_btgt,F_msy 
2 # MSY: 1= set to F(SPR); 2=calc F(MSY); 3=set to F(Btgt); 4=set to F(endyr) 
0.5 # SPR target (e.g. 0.40)
0.4 # Biomass target (e.g. 0.40)
#_Bmark_years: beg_bio, end_bio, beg_selex, end_selex, beg_relF, end_relF, beg_recr_dist, end_recr_dist, beg_SRparm, end_SRparm (enter actual year, or values of 0 or -integer to be rel. endyr)
0 0 0 0 0 0 0 0 0 0
2 #Bmark_relF_Basis: 1 = use year range; 2 = set relF same as forecast below
#
1 # Forecast: 0=none; 1=F(SPR); 2=F(MSY) 3=F(Btgt); 4=Ave F (uses first-last relF yrs); 5=input annual F scalar
12 # N forecast years 
1 # F scalar (only used for Do_Forecast==5)
#_Fcast_years:  beg_selex, end_selex, beg_relF, end_relF, beg_recruits, end_recruits  (enter actual year, or values of 0 or -integer to be rel. endyr)
0 0 0 0 0 0
1 # Control rule method (1=catch=f(SSB) west coast; 2=F=f(SSB) ) 
0.40 # Control rule Biomass level for constant F (as frac of Bzero, e.g. 0.40); (Must be > the no F level below) 
0.10 # Control rule Biomass level for no F (as frac of Bzero, e.g. 0.10) 
0.896 # Control rule target as fraction of Flimit for 2028 based on PEPtools::get_buffer(years = 2017:2028, sigma = 0.5, pstar = 0.45)
3 #_N forecast loops (1=OFL only; 2=ABC; 3=get F from forecast ABC catch with allocations applied)
3 #_First forecast loop with stochastic recruitment
-1 #_Forecast loop control #3 (reserved for future bells&whistles) 
0 #_Forecast loop control #4 (reserved for future bells&whistles) 
0 #_Forecast loop control #5 (reserved for future bells&whistles) 
2050  #FirstYear for caps and allocations (should be after years with fixed inputs) 
0 # stddev of log(realized catch/target catch) in forecast (set value>0.0 to cause active impl_error)
0 # Do West Coast gfish rebuilder output (0/1) 
2001 # Rebuilder:  first year catch could have been set to zero (Ydecl)(-1 to set to 1999)
2011 # Rebuilder:  year for current age structure (Yinit) (-1 to set to endyear+1)
1 # fleet relative F:  1=use first-last alloc year; 2=read seas(row) x fleet(col) below
# Note that fleet allocation is used directly as average F if Do_Forecast=4 
2 # basis for fcast catch tuning and for fcast catch caps and allocation  (2=deadbio; 3=retainbio; 5=deadnum; 6=retainnum)
# Conditional input if relative F choice = 2
# Fleet relative F:  rows are seasons, columns are fleets
#_Fleet:  Fishery POP EarlyTriennial LateTriennial AFSCSlope NWFSCSlope NWFSCcombo
#  1 0 0 0 0 0 0
# enter list of fleet number and max for fleets with max annual catch; terminate with fleet=-9999
-9999 -1
# enter list of area ID and max annual catch; terminate with area=-9999
-9999 -1
# enter list of fleet number and allocation group assignment, if any; terminate with fleet=-9999
1 1
-9999 -1
#_if N allocation groups >0, list year, allocation fraction for each group 
# list sequentially because read values fill to end of N forecast
# terminate with -9999 in year field 
 -9999  1 
2 # basis for input Fcast catch: -1=read basis with each obs; 2=dead catch; 3=retained catch; 99=input Hrate(F)
#enter list of Fcast catches; terminate with line having year=-9999
#Year Seas Fleet Catch
2017 1 1 5276
2017 1 2 300
2017 1 3 217
2017 1 4 381.63
2018 1 1 5105
2018 1 2 300
2018 1 3 208.95
2018 1 4 367.47
2019 1 1 5625.98
2019 1 2 414.41
2019 1 3 75.35
2019 1 4 167.60780287474333
2020 1 1 5363.46
2020 1 2 395.08
2020 1 3 71.83
2020 1 4 159.7946611909651
2021 1 1 5420.8
2021 1 2 399.3
2021 1 3 72.6
2021 1 4 161.49897330595485
2022 1 1 5224.58
2022 1 2 384.85
2022 1 3 69.97
2022 1 4 155.6570841889117
2023 1 1 5076.74
2023 1 2 373.96
2023 1 3 67.99
2023 1 4 151.25256673511294
2024 1 1 4981.76
2024 1 2 366.96
2024 1 3 66.72
2024 1 4 148.4188911704312
2025 1 1 4663.38
2025 1 2 343.51
2025 1 3 62.46
2025 1 4 138.93223819301846
2026 1 1 4628.58
2026 1 2 340.94
2026 1 3 61.99
2026 1 4 137.8952772073922
2027 1 1 4603.89
2027 1 2 339.13
2027 1 3 61.66
2027 1 4 137.16632443531827
2028 1 1 4579.61
2028 1 2 337.34
2028 1 3 61.33
2028 1 4 136.43737166324433
-9999  1  1  1
999 # verify end of input
