# Joining the 3 datasets: start with flights, make sure it's the left argument in the left join. It'll take two joins.


library(tidyverse)
library(lubridate)
flights <- read.csv('data/nyc_13_flights_small.csv')
planes <- read.csv('data/nyc_13_planes.csv')
weather <- read.csv('data/nyc_13_weather.csv')

flights_planes <- left_join(flights, planes, by = 'tailnum')
mega_data <- left_join(flights_planes, weather, by = c('time_hour', 'origin'))


# 1: Plot the departure delay of flights against the precipitation and include a simple regression line as part of the plot. Hint: there is a geom_ that will plot a simple y ~ x regression line for you, but you might have to use an argument to make sure it's a regular linear model (lm). Use ggsave to save your ggplot objects into a new folder you create called "plots." 

q1plot <- ggplot(mega_data, aes(x = precip, y = dep_delay, color = precip)) + 
  geom_point() + 
  geom_smooth(method = lm) + 
  theme_classic() +
  scale_color_viridis_c() + 
  xlab("Precipitation (Inches?)") +
  ylab("Arrival Delay Time")

q1plot

getwd()
dir.create("plots")
ggsave("plots/q1plot.png", plot = q1plot, width = 6, height = 4, units = "in")

# 2: Create a figure that has date on the x axis and each day's mean departure delay on the y axis. Plot only months Sept thru Dec. Distinguish between airline carriers (method up to you). Save final product to plot folder.

by_date <- mega_data %>% 
  select(month.x, day.x, dep_delay, carrier) %>% 
  filter(!is.na(dep_delay)) %>% 
  group_by(month.x, day.x, carrier) %>% 
  summarize(mean(dep_delay))

colnames(by_date) <- c("month.x", "day.x", "carrier", "dep_delay_avg")


q2plot <- by_date %>% 
  filter(month.x > 8) %>% 
  ggplot(aes (x= day.x, y = dep_delay_avg, color = carrier)) + 
  geom_point(mapping = aes(fill = carrier)) + 
  facet_wrap(~month.x, scales = "free") +
  scale_color_viridis_d() +
  theme_classic()

q2plot
ggsave("plots/q2plot.png", plot = q2plot, width = 6, height = 4, units = "in")

# 3: Create a dataframe w these columns: date(year, month, day), mean_temp, where each row represents the airport, based on airport code. Save this as a new csv in your data folder called mean_temp_by_origin.csv

mega_data_date <- mega_data %>% 
  mutate (date = paste(year.x, " ", month.x, " ", day.x, sep = ""))

?mutate

mean_temp_airport <- mega_data_date %>% 
  select(origin, date, temp) %>% 
  group_by(origin, date) %>% 
  summarize(mean_temp = mean(temp)) %>% 
  pivot_wider(names_from = "date", values_from = "mean_temp")

unique(mega_data$origin) #EWR JFK LGA

?summarize

write.csv(mean_temp_airport, '/Users/lauren/Desktop/R_DAVIS_2021/r-davis-in-class-project-lghitt/data/mean_temp_by_airport.csv', row.names = TRUE)
getwd()


# 4: Make a function that can: 1) convert hours to minutes; 2) convert minutes to hours (requires a conditional setting in the function that determines which direction the conversion is going). Use this function to convert departure delay (currently in minutes) to hours and then generate a boxplot of departure delay times by carrier. Save this function into a script called "customFunctions.R" in your scripts/code folder


time_conversion_h_to_m <- function(hrs_dep_delay, dat = mega_data) {
  hrs_dep_delay = (mega_data$dep_delay / 60)
  q4plot <- ggplot(mega_data, aes(x = carrier, y = hrs_dep_delay, fill = carrier)) +
    geom_boxplot() +
    scale_color_viridis_d() +
    theme_classic()
  return(q4plot)
}

time_conversion_h_to_m()

source('scripts/customFunctions.R')


# 5: Below is the plot we generated from the new data in Q4. Base code: ggplot(df, aes(x=dep_delay_hrs, y=carrier, fill=carrier)) + geom_boxplot(). the goal is to visualize delays by carrier. Do at least 5 things to improve this plot by changing, adding, or subtracting to this plot. Remember we often reduce data to more succinctly communicate things.

#Edits: 1) convert boxplot to violin plot 2) use viridis color palette for accessibility/printability 3) jitter 4) label axes & title 5) flip x & y axes (just my personal opinion: I think that mapping a discrete variable against a continuous variable is more readable with the discrete variable on the x-axis)

#Edit 6): the assignment directions said to remember that we often reduce data to more succintly communicate things; with my edits I kind of did the opposite (by adding the jitter). One thing I noticed about this data is that it has some extreme outliers, and one way to make this graph more readable might be to remove the extreme ones. I personally think that removing outliers can be problematic for real science/data analysis, but for the purposes of this assignment I gave it a try just to see how removing the outliers would affect the appearance of the rest of the plot (see q5_b plot)

q5_a <- function(hrs_dep_delay, dat = mega_data) {
  hrs_dep_delay = (mega_data$dep_delay / 60)
  q5a_plot <- ggplot(mega_data, aes(x = carrier, y = hrs_dep_delay, fill = carrier)) +
    geom_jitter(mapping = aes(color = carrier)) + 
    geom_violin(mapping = aes(fill = carrier)) +
    scale_color_viridis_d() +
    scale_fill_viridis_d() +
    theme_classic() + 
    labs(x = "Carrier",
         y = "Departure Delay Time (hours)", 
         title = "Departure Delays by Carrier")
  return(q5a_plot)
}

?geom_violin
q5_a()



q5_b <- function(hrs_dep_delay, dat = mega_data) {
  hrs_dep_delay = (mega_data$dep_delay / 60)
  q5b_plot <- ggplot(mega_data, aes(x = carrier, y = hrs_dep_delay, fill = carrier)) +
    geom_jitter(mapping = aes(color = carrier)) + 
    geom_violin(mapping = aes(fill = carrier)) +
    ylim(-0.5, 10) +
    scale_color_viridis_d() +
    scale_fill_viridis_d() +
    theme_classic() + 
    labs(x = "Carrier",
         y = "Departure Delay Time (hours)", 
         title = "Departure Delays by Carrier (Outliers Removed")
  return(q5b_plot)
}

q5_b()
