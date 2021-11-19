library(tidyverse)
library(lubridate)

mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

# Q1: Use the readme file associated with the mauna loa dataset to determine in what timezone the data are reported and how missing values are reported in each column. 

# A1: 
#UTC; missing values differ for each of the columns: wind direction = -999, wind speed = -99.9 (typo in readme file!!!), wind steadiness factor = -9, barometric pressure = -999.90, temp2m = -999.9, temp10m = -999.9, temptowertop = -999.9, relative humidity = -99, precipitation intensity = -99


# Q2: With the mloa data.frame, remove observations with missing values in rel_humid, temp_c_2m, and windSpeed_m_s. 
# A2:
mloa_subset = mloa %>%  
  filter(rel_humid!=-99, temp_C_2m!=-999.9, windSpeed_m_s!=-99.9)

# Q3: Generate a column called "datetime" using the year, month, day, hour24, and min columns. 

# A3: 
paste(mloa_subset$year, mloa_subset$month)
paste(mloa_subset$year, mloa_subset$month, sep='-')
paste0(mloa_subset$year, mloa_subset$month)


mloa_subset %>% 
  mutate(datetime = ymd(paste(year,month,day,sep = "-"))) %>% 
  select(datetime)

mloa_subset %>% 
  mutate(datetime = paste(year,month,day,sep = '-')) %>% 
  mutate(datetime = ymd(datetime)) %>% 
  select(datetime)
  

mloa_subset = mloa_subset %>% 
  mutate(datetime = ymd_hm(paste(year,month,day,hour24,min, sep = '-')))

# Q4: Next, create a column called "datetimeLocal" that converts the datetime column to Pacific/Honolulu time (HINT: look at the lubridate function called with_tz()). 
# A4:
?with_tz

mloa_subset = mloa_subset %>% 
  mutate(datetimeLocal = with_tz(datetime, tzone = "Pacific/Honolulu"))

# Q5: Then, use dplyr to calculate the mean hourly temperature each month using the temp_C_2m column and the datetimeLocal columns (HINT: Look at the lubridate functions called month() and hour()). Finally, make a ggplot scatterplot of the mean monthly temperature w points colored by local hour

# A5: 
?month() #get/set months component of a date-time
?hour() #get/set hours component of a date-time

mloa_subset %>%
  mutate(local_month = month(datetimeLocal), local_hour = hour(datetimeLocal)) %>% 
  group_by(local_month, local_hour) %>% 
  summarize(meantemp = mean(temp_C_2m)) %>% 
  ggplot(aes(x = local_month, y = meantemp)) +
  geom_point(aes(col = local_hour)) + 
  theme_classic() + 
  scale_color_continuous() +
  scale_x_continuous(breaks=seq(0, 12, 2)) +
  xlab("Month") +
  ylab("Mean temperature (degrees C)")


  