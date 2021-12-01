###  Function Writing! ###

library(tidyverse)
library(gapminder)

# Function = a bundle of operations, typically with arguments to be specified

my_sum <- function(number1, number2){
  the_sum <- number1 + number2
  return(the_sum)
}

my_sum(number1 = 10, number2 = 5)
my_sum(10, 5)

# R actually automatically returns the value but not all coding languages do so 




# Gapminder: average gdp per cap over a range of years
summary(gapminder)

gapminder %>% 
  filter(country == "Canada", year %in% 1970:1980) %>% 
  summarize(avgGDP = mean(gdpPercap, na.rm = T))

avgGDP <- function(cntry, yr.range) {
  gapminder %>% 
    filter(country == cntry, year %in% yr.range) %>% 
    summarize(avgGDP = mean(gdpPercap, na.rm = T))
}

avgGDP(cntry= "Iran", yr.range = 1985:1990)
avgGDP(cntry= "Zambia", yr.range = 1900:2020)

# What if I want to do it over and over again for every observation in my data?

unique(gapminder$country) 
unique(gapminder$country) [1:10]

#Iteration is our friend!
#3 kinds: for-loops, apply functions and map functions

# Often times when we want to iterate it can't be vectorized
avgGDP(cntry = unique(gapminder$country[1:10], yr.range = 1985:1990))
# didn't work because ____


# Iterating for for-loops

for(i in 1:10){
  print(i)
}

# But items within functions are 'pass by' values and don't save to the environment. Often don't even return

#could start by printing within lops:
for(i in unique(gapminder$country)[1:10]){
  print(avgGDP(i, yr.range = 1985:1990))
}

# What if you want it saved? These DO NOT WORK:
output <- for(i in unique(gapminder$country)[1:10]) {
  print(avgGDP(i, yr.range = 1985:1990))
}
output #NULL

for(i in unique(gapminder$country)[1:10]) {
  output <- avgGDP(i, yr.range = 1985:1990)
}
output #output has only one observation of one variable, the very last observation ran through the function

# the pass by feature means it will only save the object for the last value of i


# SOLUTION: Create an empty container outsidd the loop, and assign it to an indexed value within the loop

output <- list()
for(i in unique(gapminder$country)[1:10]){
  output[i] <- avgGDP(i, yr.range = 1985:1990)
}
output
do.call(rbind, output)
data.frame(unlist(output))


# Challenge: load and access the life expectancy dataset. Write a new function that takes two arguments, the gapminder data.frame(d) and the name of a country (e.g., "Afghanistan"), and plots a time series of the country's population. That is, the return value from the function should be a ggplot object. It is often easier to modify existing code than to start from scratch. 

#To start out with, try writing some code that works interactively, then wrap it in a function. 

d <- gapminder:: gapminder













# Could also make this a dataframe, but dataframes are more rigid about columns though can be useful if _____


output <- data.frame()
for(i in unique(gapminder$country)[1:10]){
  df <- data.frame(country = i,
                   output = avgGDP(i, yr.range = 1985:1990))
  colnames
  output <- rbind(df, output)
}
output

# function requires 2 arguments, I'm going to make it one for now
avgGDP <- function(cntry){
  gapminder %>%
    filter(country == cntry, year %in% 1990:2000) %>%
    summarize(avgGDP = mean(gdpPercap, na.rm = T))
}

sapply(unique(gapminder$country)[1:10], avgGDP)
map_df(unique(gapminder$country)[1:10], avgGDP)


library(gapminder)

plotPopGrowth <- function(countrytoplot, dat = gapminder) {
  df <- filter(dat, country == countrytoplot)
  plot <- ggplot(df, aes(year, pop)) +
    geom_line() +
    labs(title = countrytoplot)
  print(plot) # return does not return these things
}
plotPopGrowth('Canada')

# If we wan to repeat this, maybe we could vectorize it?
plotPopGrowth(unique(gapminder$country)[1:10])

# Iterating for for-loops
for(i in unique(gapminder$country)[1:10]){
  plotPopGrowth(i)
}

# iterating map functions
map(unique(gapminder$country)[1:10], plotPopGrowth)

# iterating with apply
sapply(unique(gapminder$country)[1:10], plotPopGrowth)



