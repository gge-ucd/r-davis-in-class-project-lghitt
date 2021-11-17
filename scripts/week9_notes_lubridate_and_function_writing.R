### Lubridate & Function Writing ###


# Dates & Lubridate
# dealing with dates in R: bit tricky to do, with real-world applications to research and usage
# object classes (characters, numbers, factors, now DATES) and their properties (e.g., for dates, month/day/year)
# lubridate package


#date-time classes in base R (year, month, day); POSIXct (CT = calendar time) and POSIXlt (LT =local time)

sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", "2019-01-01", "2019-02-18")

str(sample_dates_1) 
# R doesn't realize this is a date; if we try to sort it R would sort it as alphabetical; if not read in with year-month-day order, it would not sort chronologically

as.Date(sample_dates_1) #generated date object that looks the same as the original object because we specified our data in the format R likes when we read it in
sample_dates_1 <- as.Date(sample_dates_1)

sample_dates_1
str(sample_dates_1)

# But what happens when date data isn't stored in R's preferred format?
sample_dates_2 <- c("02-01-2018", "03-21-2018", "10-05-2018", "01-01-2019", "02-18-2019")

sort(sample_dates_2) #sorted by month instead of by year because it sorted by ascending by the first values listed in the date
str(sample_dates_2)
sample_dates_3 <- as.Date(sample_dates_2)
str(sample_dates_3) #very weird, and some of the dates are now NA values

sample_dates_3 <- as.Date(sample_dates_2, format = "%m-%d-%Y") #case sensitive!! 

str(sample_dates_3) #Huzzah!

tm2 <- as.POSIXct("25072016 08:32:07", format = "%d%m%Y %H:%M:%S")
tm2

# lubridate: hardwired some conversion functions
install.packages('lubridate')
library(lubridate)

sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", "2019-01-01", "2019-02-18") #data fed in in Y-M-D format

lubridate:: ymd(sample_dates_1)
lubridate:: mdy(sample_dates_1) #failed to parse
lubridate:: dmy()

dec = lubridate::decimal_date(ymd(sample_dates_1))
#decimal value of a date (decimal of Julian value?)

lubridate:: date_decimal(dec)



# Function Writing

#Function = operations, usually specified with one or more arguments

# A summing function, with no built-in arguments:
2 + 3 #output = 5

my_sum <- function(number1, number2){
  the_sum <- number1 + number2
  return(the_sum)
}

my_sum(number1 = 10, number2 = 5)
my_sum(10, 5)

# A summing function (again), but with default values for arguments

my_sum2 <- function(number1 = 5, number2=10){
  the_sum <- number1 + number2
  return(the_sum)
}
my_sum2()
my_sum2(number1 = 10) #why hardcode a value into a function? 

# temperature conversion

F_to_K <- function(tempF){
  K <- ((tempF - 32) * (5/9)) + 273.15
  return(K)
}

F_to_K(80)

# Gapmind dataset: Average GDP per capita over a range of years

library(tidyverse)

install.packages('gapminder')
library(gapminder)

summary(gapminder)

gapminder %>% 
  filter(country == "Canada", year %in% 1970:1980) %>% 
  summarize(mean(gdpPercap, na.rm = T))

avgGDP <- function(cntry, yr.range){
  gapminder %>% 
    filter(country == "Canada", year %in% 1970:1980) %>% 
    summarize(mean(gdpPercap, na.rm = T))
}

#softcoded version:

avgGDP2 <- function(cntry, yr.range){
  gapminder %>% 
    filter(country == cntry, year %in% yr.range) %>% 
    summarize(mean(gdpPercap, na.rm = T))
}

avgGDP2(cntry = "Iran", yr.range = 1985:1990)
avgGDP2(cntry = "Zambia", yr.range = 1900:2020)

