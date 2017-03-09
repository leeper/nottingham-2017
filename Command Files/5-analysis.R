# Created by Thomas Leeper
# This version:  2017-03-08
# Written for R 3.3.0, 64-bit, for Windows

library("rio")
library("ggplot2")

#TABLE 1
#(USING COUNTRY-LEVEL DATA)
country <- rio::import("../Analysis Data/country-analysis.dta")
aggregate(cbind(cm_satis, inc, exp) ~ CountryName, data = country, FUN = mean)

#TABLE 2, COLUMN 1
#(USING INDIVIDUAL-LEVEL DATA)
individual <- rio::import("../Analysis Data/individual-analysis.dta")
summary(lm(satis ~ age + age2, data = individual))

#TABLE 2, COLUMN 2
#(USING INDIVIDUAL-LEVEL DATA)
summary(lm(satis ~ age + age2 + factor(country), data = individual))

#FIGURE 1
#(USING COUNTRY-LEVEL DATA)
ggplot(country, aes(x = inc, y = cm_satis)) + 
  geom_point() + 
  geom_text(aes(label = CountryName))

#FIGURE 2
#(USING COUNTRY-LEVEL DATA)
ggplot(country, aes(x = exp, y = cm_satis)) + 
  geom_point() + 
  geom_text(aes(label = CountryName))

#TEXT ON PAGE 4 OF THE PAPER, STATING THAT,
#WHEN COUNTRY FIXED EFFECTS ARE  NOT INCLUDED IN THE REGRESSION,
#ESTIMATED AGE AT MINIMUM SWB IS ABOUT
#47 YEARS AND 9 MONTHS
#(USING INDIVIDUAL-LEVEL DATA) 
local({
    x <- lm(satis ~ age + age2, data = individual)
    -coef(x)["age"]/(2*coef(x)["age2"])
})

#TEXT ON PAGE 4 OF THE PAPER, STATING THAT,
#WHEN COUNTRY FIXED EFFECTS ARE INCLUDED IN THE REGRESSION,
#THE ESTIMATED AGE AT MINIMUM SWB IS ABOUT
#53 YEARS AND 11 MONTHS
#(USING INDIVIDUAL-LEVEL DATA)
local({
    x <- lm(satis ~ age + age2 + factor(country), data = individual)
    -coef(x)["age"]/(2*coef(x)["age2"])
})

