#Reading data into R
hi <- read.csv("D:/Jaga/CS84/Project/HawaiiCounty5yrs.csv",header = TRUE, sep = ",")


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



