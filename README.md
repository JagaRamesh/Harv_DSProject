## 2020 Voter Prediction for Hawaii, North Dakota
###Author Note

Jaga Ramesh - Student of CS-84 Fall 2016 “A Practical Approach to Data Science”.
The analysis on 2020 Voter prediction for Hawaii & North Dakota is conducted as a part of final project submission for CS-84 class. Correspondence concerning this article should be addressed to [Jaga Ramesh](jagadeeswari.ramesh@gmail.com).

###Abstract

Historical election data from 2000 to 2016 was gathered for the states under consideration. The data was gathered at the county level and at the state level. The voting pattern against 3 major groups were analyzed - age, gender, and race. Statistical analysis was performed to check for the correlation between the voting groups and the voting pattern. Based on the analysis, statistical models were created for the 2020 voter prediction for the states – Hawaii and North Dakota. Linear regression, Monte Carlo simulation were the models used in the analysis and the findings were shared in this document.

###Introduction

The objective of this project to predict the outcome of the 2020 election for the states - Hawaii and North Dakota. In these states, the top voter issues, GDP, voting groups like Age, Race and gender and its impact to voter’s outcome was analyzed and a best fit model was derived to predict the party that will win in 2020 election. 

###Hawaii Analysis

Hawaii has diverse culture and the immigrant groups from many south Asian countries. The major source of income is tourism. [Hawaii’s economy] (http://dbedt.hawaii.gov/economic/qser/outlook-economy/) depends significantly on conditions in the U.S. economy and key international economies, especially Japan. Hawaii’s economy, as measured by real GDP, is projected to show a 2.0% increase in 2016 , 1.9% in 2017, 1.7% in 2018 and 1.6% in 2019.  
  
Economic Indicators |	2014 |	2015 |	2016 |	2017 |	2018 |	2019 
--------------------|------|-------|-------|-------|-------|--------
Total population (thousands) | 1,420 | 1,432 | 1,443 | 1,455 | 1,468 | 1,481
Real personal income (millions of 2009$)² |	51,866 | 53,815 | 55,107 | 56,540 | 57,953 | 59,402
Real gross domestic product (millions of 2009$) | 69,662 | 70,845 | 72,262 | 73,635 | 74,887 | 76,085

The **top industries** in Hawaii that contribute to GDP Economic development are 
* Tourism
* Defense
* Agricultural products production(Sugarcane, Pineapple, Coffee, Macadamia nuts)
* Apparel and cotton based products manufacturing
* Service industry (hotels, private healthcare, finance, and real estate)

Even though Hawaii is a visitor magnet and the population is increasing in the island each year, the paradise also has its downside. The **top issues** that concerns people in Hawaii are:

1. Homelessness (Hawaii has the highest per capita rate of homelessness in US)
2. Housing (Lack of inventory , high home prices)
3. Transportation (Road way system is under-built)
4. Economy (Hawaii is spending more that it takes)
5. HealthCare (Inadequate access to Health facilities, Increasing drug use and deficient mental health programs)

The **gender analysis** shows an approximately equal percentages of male & female in the voting population for the last 5 elections (Male: 48-51%; Female: 49-52%). **Age analysis** shows that 60-65% of the voting population are from the age groups 25 to 44 and 45 to 64. Race analysis shows that Asian population is dominant (40%) in the state. Cross cultural marriages leads to increase in population of two or more races. White population and the “Two or more races” population are close to 30% each. 
Hawaii’s voter turnout is the lowest in USA. The **multicultural state favored Democrats** in every presidential election from 2000 to 2016. The above factors are taken into consideration in arriving at the best fit model for state Hawaii.

###Method
The forecasted 2020 Hawaii’s county wise population is gathered from [Hawaii gov website](http://files.hawaii.gov/dbedt/economic/data_reports/2040-long-range-forecast/2040-long-range-forecast.pdf). Using the historical data, the median percentage of voter turnout to total population is calculated and the 2020 voter turnout is derived.

**2020 forecasted Voter turnout for each county 
= 2020 forecasted population per county * Median voter turnout % from past data**

From the analysis of voting groups, it is found that there is no major difference in the age / gender / race groups voting population distribution in the last 5 election. Statistical analysis revealed no strong correlation between voting pattern and the voting groups in Hawaii. When the analysis was done at the county level, it is identified that the voter turnout has a strong correlation to the democrat and republic votes and is found to be statistically significant variable to determine the democrat and the republic votes for 2020. So Linear regression model in R programing language is used to predict the 2020 Hawaii election outcome.

###Code
```{r}
#Reading data into R
hi <- read.csv("/data/HawaiiCounty5yrs.csv",header = TRUE, sep = ",")


# Load 5 years of data excluding 2020 
hi1 <- subset(hi, hi$year != "2020")


# Calculating median for voter turnout % at County level
library(plyr)
hi1_median <- ddply(hi1, c("state","county"), summarise,
                    turnout_per_median = round(median(turnout_per),4))

# Voter turnout calculation for 2020 prediction
library(sqldf)
sql_string <- "SELECT hi1_median.*,hi.total_pop
               from hi INNER JOIN hi1_median 
               on hi.county = hi1_median.county
               where hi.year= '2020' "
hi_2020 <- sqldf(sql_string, stringsAsFactors = FALSE)
hi2 <- hi_2020
hi2$voter_turnout = round(hi2$total_pop * hi2$turnout_per_median,0)

# Linear regresion for Dem & Rep votes
#dem.lm <- lm(hi1$dem_votes ~ hi1$voter_turnout)
#summary(dem.lm)
#coef(dem.lm)
#confint(dem.lm)

#rep.lm <- lm(hi1$rep_votes ~ hi1$voter_turnout)
#summary(rep.lm)
#coef(rep.lm)
#confint(rep.lm)

# Linear Regression Equations for party votes and 95% conf int
# demvotes = 2049.57 + (0.5966 * voter_turnout)
# repvotes = -3423.76 + (0.3659 * voter_turnout)
# u.dem = 10409.73 + (0.6529 * voter_turnout)
# l.dem = -6310.59 + (0.5403 * voter_turnout)
# l.rep = -11115.97 + (.3141 * voter_turnout)
# u.rep = 4268.45 + (0.4178 * voter_turnout)
# othvotes = voter_turnout - (demvotes + repvotes)

hi2$calc_dem_votes =  round(2049.57 + (0.5966 * hi2$voter_turnout),0)
hi2$calc_rep_votes =  round(-3423.76 + (0.3659 * hi2$voter_turnout),0)
hi2$calc_oth_votes =  round(hi2$voter_turnout - (hi2$calc_dem_votes + hi2$calc_rep_votes),0)

hi2$u.dem = round(10409.73 + (0.6529 * hi2$voter_turnout),0)
hi2$l.dem = round(-6310.59 + (0.5403 * hi2$voter_turnout),0)
hi2$u.rep = round(4268.45 + (0.4178 * hi2$voter_turnout),0)
hi2$l.rep = round(-11115.97 + (.3141 * hi2$voter_turnout),0)

hi2$u.dem = ifelse(hi2$u.dem < 0, 0, hi2$u.dem)
hi2$l.dem = ifelse(hi2$l.dem < 0, 0, hi2$l.dem)
hi2$u.rep = ifelse(hi2$u.rep < 0, 0, hi2$u.rep)
hi2$l.rep = ifelse(hi2$l.rep < 0, 0, hi2$l.rep)

# Summarizing Results
hi2_sum <- ddply(hi2, c("state"),summarise,
                 total_pop = sum(hi2$total_pop),
                 voter_turnout = sum(hi2$voter_turnout),
                 calc_dem_votes = sum(hi2$calc_dem_votes),
                 calc_rep_votes = sum(hi2$calc_rep_votes),
                 calc_oth_votes = sum(hi2$calc_oth_votes),
                 u.dem = sum(hi2$u.dem),
                 l.dem = sum(hi2$l.dem),
                 u.rep = sum(hi2$u.rep),
                 l.rep = sum(hi2$l.rep)
                 )


Democrat <- c(round(hi2_sum$calc_dem_votes/1000,0), 
              round(hi2_sum$u.dem/1000,0), 
              round(hi2_sum$l.dem/1000,0)
              )
Republic <- c(round(hi2_sum$calc_rep_votes/1000,0),
              round(hi2_sum$u.rep/1000,0), 
              round(hi2_sum$l.rep/1000,0)
              )
Others <- c(round(hi2_sum$calc_oth_votes/1000,0), 
            round((hi2_sum$voter_turnout-(hi2_sum$u.dem+hi2_sum$l.rep))/1000,0),
            round((hi2_sum$voter_turnout-(hi2_sum$l.dem+hi2_sum$u.rep))/1000,0)
            )

bp <- data.frame(Democrat,Republic,Others)
bp$Others = ifelse(bp$Others < 0, 0, bp$Others)

# Boxplot to show results
#install.packages("RColorBrewer")
library(RColorBrewer)
boxplot(bp,
        ylim = c(0,350),
        horizontal = TRUE,
        #las = 1,
        col=brewer.pal(3,"Pastel2"),
        boxwex = 0.5, whisklty = 1, 
        staplety=0,
        main = "2020 Hawaii Voter prediction with 95% confidence",
        ylab = "Party",
        xlab = "No of votes in 1000s"
        )

```
###Results
![Hawaii_results](/Images/Hawaii_results.png)

From the statistical analysis for Hawaii, it is concluded with 95% confidence that in 2020 election, the Democratic Party wins and the Republican Party loses in Hawaii. 
The party votes will be in the following range:

* Democrat: 285,936 (95% confident that democrat votes will be between 226,287
 and 345,586)
* Republic: 156,643 (95% confident that republic votes will be between 103,857 and 211,574)
* Others : 22,956 (95% confident that other votes will be between 16,092 and 27,674)

The following polls supports the 2020 prediction for Hawaii

1.	[Washington Post](https://www.washingtonpost.com/news/the-fix/wp/2014/08/12/51-charts-on-the-2020-elections-yes-you-read-that-right/?utm_term=.3df3134f91cb)
2.	[future.wikia.com](http://future.wikia.com/wiki/US_Presidential_Election_2020_(Joe'sWorld)?file=Castro2020_predictionmap.jpg)

###North Dakota Analysis

North Dakota is located in the Upper Midwestern region of the United States.
It is the most rural of all the states, with farms covering more than 90% of the land. North Dakota ranks first in the nation's production of spring and durum wheat; other agricultural products include barley, rye, sunflowers, dry edible beans, honey, oats, flaxseed, sugar beets, hay, beef cattle, sheep, and hogs. The state's coal and oil reserves are plentiful, and it also produces natural gas, lignite, clay, sand, and gravel.

The top industries in North Dakota that contribute to GDP Economic development are 

* Agriculture 
* Oil
* Tourism (in 2013, 24 million visited North Dakota, and they spent 3.6 billion)
* Coal Gasification (9th in the country in coal production)
* Renewable energy (home for renewable energy including wind, bioenergy and ethanol power)

The top issues that the state faces :

* Budget ($1 billion deficit)
* Economy (Impact to state’s economy due to decline in oil prices)
* Energy / Environment (Federal rule to reduce CO2 emission by 45% before 2030)

The **gender analysis** shows an approximately equal percentages of male & female in the voting population for the last 5 elections (Male: 49-50%; Female: 50-51%). **Age analysis** shows that 66-71% of the voting population are from the age groups 25 to 44 and 45 to 64. Race analysis shows that White population is dominant (89-95%) in the state. **North Dakota’s voter turnout is 61 to 65%** of the voting population. The agricultural state favored Republicans in every presidential election from 2000 to 2016. The above factors are taken into consideration in arriving at the best fit model for state North Dakota.

###Method

In North Dakota, the GDP is expected to increase in the next coming years 2017 to 2020. The voter turnout is consistently high in the past 5 elections and ranges between 61 to 65% of the total population. The forecasted 2020 North Dakota’s county wise population is gathered from [here](chrome-extension://gbkeegbaiigmenfmjfclcdgdpimamgkj/views/app.html). 

From the analysis of voting groups, it is found that there is no major difference in the age / gender / race groups voting population distribution in the last 5 elections. Statistical analysis revealed no strong correlation between voting pattern and the voting groups. The North Dakota has 53 counties. **Using the historical election data of 53 counties for the last 5 years, Monte Carlo analysis is performed to determine the likelihood of Republican Party’s win in the 2020 election.** 

The county wise Voter turnout %, democratic vote’s %, Republican vote’s %, and the other Party vote’s % are gathered from the historical election data and the Mean and Standard deviation for those is calculated. The random normal distribution is used to randomly generate Voter turnout %, democratic vote’s %, Republican vote’s %, and the other Party vote’s % based on the calculated mean and standard deviation. The Monte Carlo analysis is performed for 100 iterations using the randomly generated percentages for political parties at the county level.  The party votes are then summed up at the state level to determine the range for 100 iterations. The histogram is used to study the range of party votes and to statistically determine the winning party in North Dakota

###Code

###Results
![Northdakota Results](/Images/Northdakota_results.png)
From the Monte Carlo analysis, it is statistically determined that in 2020 election, the Republican Party wins and the Democratic Party loses in North Dakota. The party votes will be in the following range:

* Voter turnout: 386,400 (Ranges between 370,000 and 401,400)
* Republic: 227,200 (Ranges between 206,000 and 240,400)
* Democrat: 135,900 (Ranges between 110,500 and 157,400)
* Others : 22,560 (Ranges between 11,920 and 34,120)

The following polls supports the 2020 prediction for North Dakota:
1.	[Washington post](https://www.washingtonpost.com/news/the-fix/wp/2014/08/12/51-charts-on-the-2020-elections-yes-you-read-that-right/?utm_term=.3df3134f91cb)
2.	[future.wikia.com](http://future.wikia.com/wiki/US_Presidential_Election_2020_(Joe'sWorld)?file=Castro2020_predictionmap.jpg)

###References

####Hawaii

1996 to 2016 County wise total population, voter turnout, party votes
* [elections.hawaii.gov](http://elections.hawaii.gov/election-results/)

1996 to 2016 Total Population, Age, Gender, Race data
* [census.hawaii.gov](http://census.hawaii.gov/home/population-estimate/)

Hawaii Economy - Top 5 industries in Hawaii 
* [newsmax.com](http://www.newsmax.com/FastFeatures/industries-hawaii-strongest-economy/2015/03/05/id/628087/)

Top issues in Hawaii 
* [hawaiifreepress.com](http://www.hawaiifreepress.com/ArticlesMain/tabid/56/ID/17421/CQ-Roll-Call-Top-5-Issues-in-Hawaii.aspx)
* [www.civilbeat.org](http://www.civilbeat.org/2015/03/what-are-the-top-five-issues-in-hawaii/)

2020 Population projection
* [files.hawaii.gov](http://files.hawaii.gov/dbedt/economic/data_reports/2040-long-range-forecast/2040-long-range-forecast.pdf)

####North Dakota

2000 to 2016 County wise total population, voter turnout
* [nd.gov](https://vip.sos.nd.gov/PortalListDetails.aspx?ptlhPKID=62&ptlPKID=4)

2000 to 2016 County wise Party votes
* [nd.gov](https://vip.sos.nd.gov/PortalListDetails.aspx?ptlhPKID=63&ptlPKID=4#content-start)


2020 Population Projection
* [2020 North Dakota](chrome-extension://gbkeegbaiigmenfmjfclcdgdpimamgkj/views/app.html)

North Dakota GDP
* [www.deptofnumbers.com](http://www.deptofnumbers.com/gdp/north-dakota/)
* [www.bea.gov](https://www.bea.gov/iTable/iTable.cfm?reqid=70&step=1&acrdn=2#reqid=70&step=10&isuri=1&7003=900&7035=-1&7004=naics&7005=-1&7006=38000&7036=-1&7001=1900&7002=1&7090=70&7007=-1&7093=levels)

North Dakota Economy
* [newsmax.com](http://www.newsmax.com/FastFeatures/industries-in-north-dakota-economy/2015/04/13/id/638158/)
* [cqrollcall.com](http://cqrollcall.com/statetrackers/top-public-policy-issues-each-state/)

Other sites
[www.infoplease.com](http://www.infoplease.com/us-states/north-dakota.html)


