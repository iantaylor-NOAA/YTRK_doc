
# read base model
dir.N <- "C:/SS/Yellowtail/Yellowtail2017/Models/North/STAR_2_NORTH"
out.N <- SS_output(dir.N)

### mean weight of WA rec catch in period since change in recruitment 2003:2016
mean.wt.WA <- mean((out.N$timeseries$"dead(B):_4"/out.N$timeseries$"dead(N):_4")[out.N$timeseries$Yr %in% 2003:2016])
mean.wt.WA
## [1] 1.056345


# recent catch (in biomass) for 2 rec fleets
recWA_recent5 <- out.N$timeseries$"dead(B):_4"[out.N$timeseries$Yr %in% 2012:2016]
recORandCA_recent5 <- out.N$timeseries$"dead(B):_3"[out.N$timeseries$Yr %in% 2012:2016]

# ratio of WA to total rec has an average of 65% of total
round(recWA_recent5/(recWA_recent5+recORandCA_recent5),2)
## [1] 0.51 0.56 0.69 0.67 0.82

# average 65/35 split of WA to OR+CA
round(mean(recWA_recent5/(recWA_recent5+recORandCA_recent5)),2)
## [1] 0.65
round(mean(recORandCA_recent5/(recWA_recent5+recORandCA_recent5)),2)
## [1] 0.35
# ratio of sums is only slightly different than average ratio
round(sum(recWA_recent5)/sum(recWA_recent5+recORandCA_recent5),2)
## [1] 0.67

## divide set aside of 620 mt and 597 mt for 2017 and 2018
0.35*620 # OR+CA in 2017
## [1] 217
0.35*597 # OR+CA in 2018
## [1] 208.95

0.65*620 # WA in 2017
## [1] 403
0.65*597 # WA in 2018
## [1] 388.05

0.65*620/mean.wt.WA
## [1] 381.5041
0.65*597/mean.wt.WA
## [1] 367.3515

#_Year Seas Fleet Catch(or_F)
2017   1    1     5276   # 5276 = 6196 ACL - 300 hake - 620 rec
2018   1    1     5105   # 5105 = 6002 ACL - 300 hake - 597 rec
2017   1    2     300    # hake set aside
2017   1    2     300    # hake set aside
2017   1    3     217    # recOR+CA = 35% of 620 set aside
2018   1    3     208.95 # recOR+CA = 35% of 597 set aside
2017   1    4     381.63 # recWA = 65% of 620 set aside / 1.056 kg/fish
2018   1    4     367.47 # recWA = 65% of 597 set aside / 1.056 kg/fish

# run base model with values above added, and starter changed to use par file,
test <- SS_output('c:/SS/Yellowtail/Yellowtail2017/Models/STAR_forecast/STAR_2_NORTH_forecast')
#then run SS_ForeCatch to get fixed catches for forecast years based on projection
SS_ForeCatch(test, yrs=2019:2028)
### note: catch is in N for fleet 4 and sum is not correct (because of N vs B)
   #Year Seas Fleet dead(B)                comment
## 1   2019    1     1 5802.79 #sum_for_2019: 6438.63
## 2   2019    1     2  268.00                       
## 3   2019    1     3   72.00                       
## 4   2019    1     4  295.84                       
## 5   2020    1     1 5509.80 #sum_for_2020: 6123.95
## 6   2020    1     2  251.24                       
## 7   2020    1     3   73.25                       
## 8   2020    1     4  289.66                       
## 9   2021    1     1 5288.62 #sum_for_2021: 5886.14
## 10  2021    1     2  238.06                       
## 11  2021    1     3   74.11                       
## 12  2021    1     4  285.35                       
## 13  2022    1     1 5132.05 #sum_for_2022: 5717.07
## 14  2022    1     2  228.10                       
## 15  2022    1     3   74.54                       
## 16  2022    1     4  282.38                       
## 17  2023    1     1 5028.26  #sum_for_2023: 5604.1
## 18  2023    1     2  220.94                       
## 19  2023    1     3   74.63                       
## 20  2023    1     4  280.27                       
## 21  2024    1     1 4962.54 #sum_for_2024: 5531.66
## 22  2024    1     2  216.04                       
## 23  2024    1     3   74.46                       
## 24  2024    1     4  278.62                       
## 25  2025    1     1 4920.88 #sum_for_2025: 5484.96
## 26  2025    1     2  212.81                       
## 27  2025    1     3   74.11                       
## 28  2025    1     4  277.16                       
## 29  2026    1     1 4892.33  #sum_for_2026: 5452.4
## 30  2026    1     2  210.69                       
## 31  2026    1     3   73.65                       
## 32  2026    1     4  275.73                       
## 33  2027    1     1 4869.51 #sum_for_2027: 5426.17
## 34  2027    1     2  209.22                       
## 35  2027    1     3   73.16                       
## 36  2027    1     4  274.28                       
## 37  2028    1     1 4848.05 #sum_for_2028: 5401.62
## 38  2028    1     2  208.09                       
## 39  2028    1     3   72.68                       
## 40  2028    1     4  272.80

# re-run model with the input fixed catches through 2026 as above
test_fixed <- SS_output('c:/SS/Yellowtail/Yellowtail2017/Models/STAR_forecast/STAR_2_NORTH_fixed_catches')

### get catch in biomass using SSplotCatch
totcatchmat <- SSplotCatch(test_fixed, forecastplot=TRUE, subplot=1)$totcatchmat
totcatchmat[totcatchmat$Yr > 2018, ]
##      CommercialTrawl HakeByCatch RecORandCA   RecWA   Yr
## 2880         5802.79     268.000    72.0000 299.315 2019
## 2881         5509.80     251.240    73.2500 287.673 2020
## 2882         5288.62     238.060    74.1100 279.787 2021
## 2883         5132.05     228.100    74.5400 274.536 2022
## 2884         5028.26     220.940    74.6300 271.088 2023
## 2885         4962.54     216.040    74.4600 268.770 2024
## 2886         4920.88     212.810    74.1100 267.083 2025
## 2887         4892.33     210.690    73.6500 265.679 2026
## 2888         4872.21     209.347    73.1763 274.393 2027
## 2889         4850.51     208.202    72.6931 272.894 2028
totcatch_fore <- totcatchmat[totcatchmat$Yr > 2018, 1:4]
totcatch_ratio <- totcatch_fore
for(icol in 1:4){
  totcatch_ratio[,icol] <- totcatch_fore[,icol]/apply(totcatch_fore, 1, sum)
}
##      CommercialTrawl HakeByCatch RecORandCA      RecWA
## 2880       0.9007599  0.04160131 0.01117647 0.04646230
## 2881       0.9000054  0.04103912 0.01196512 0.04699032
## 2882       0.8993369  0.04048242 0.01260250 0.04757815
## 2883       0.8989047  0.03995288 0.01305606 0.04808638
## 2884       0.8987192  0.03948941 0.01333889 0.04845254
## 2885       0.8987162  0.03912485 0.01348471 0.04867426
## 2886       0.8988101  0.03887024 0.01353636 0.04878333
## 2887       0.8989372  0.03871306 0.01353276 0.04881697
## 2888       0.8974206  0.03855998 0.01347847 0.05054091
## 2889       0.8975280  0.03852525 0.01345098 0.05049572

totcatch_recent5 <- totcatchmat[totcatchmat$Yr %in% 2012:2016, 1:4]
totcatch_recent5_ratio <- totcatch_recent5
for(icol in 1:4){
  totcatch_recent5_ratio[,icol] <- totcatch_recent5[,icol]/apply(totcatch_recent5, 1, sum)
}

bio_ratios <- round(apply(totcatch_recent5_ratio, 2, mean), 3)
## CommercialTrawl     HakeByCatch      RecORandCA           RecWA 
##           0.896           0.066           0.012           0.026 
sum(bio_ratios)
## [1] 1

2000 * bio_ratios
## CommercialTrawl     HakeByCatch      RecORandCA           RecWA 
##            1792             132              24              52 
4000 * bio_ratios
## CommercialTrawl     HakeByCatch      RecORandCA           RecWA 
##            3584             264              48             104 

# convert WA to numbers
52/mean.wt.WA
# 49.2
104/mean.wt.WA
# 98.5

#### 2000 mt total catch stream
#_Year Seas Fleet Catch(or_F)
2019   1    1     1792
2019   1    2     132    
2019   1    3     24     
2019   1    4     49.2 # converted from 52mt to numbers

#### 4000 mt total catch stream
#_Year Seas Fleet Catch(or_F)
2019   1    1     3584
2019   1    2     264   
2019   1    3     48     
2019   1    4     98.5 # converted from 104mt to numbers

### then manually repeat these through 2028

base_low_catch <- SS_output('C:/SS/Yellowtail/Yellowtail2017/Models/STAR_forecast/BASE_NORTH_low_catch')
base_med_catch <- SS_output('C:/SS/Yellowtail/Yellowtail2017/Models/STAR_forecast/BASE_NORTH_med_catch')
base_high_catch <- SS_output('C:/SS/Yellowtail/Yellowtail2017/Models/STAR_forecast/BASE_NORTH_high_catch')

SSplotComparisons(SSsummarize(list(base_low_catch, base_med_catch, base_high_catch)), endyrvec=2028)
