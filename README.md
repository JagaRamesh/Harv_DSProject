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

You can use the [editor on GitHub](https://github.com/JagaRamesh/HarvardEXT_DSProject/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/JagaRamesh/HarvardEXT_DSProject/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
