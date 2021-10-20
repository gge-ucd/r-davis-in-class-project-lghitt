### TidyVerse time! ###

library(tidyr)


surveys <- read_csv('data/portal_data_joined.csv')


### Challenge 1: keep only observations before 1995 ###


surveys_challenge <- surveys %>% 
  filter(year < 1995) %>% 
  select(year, sex, weight)



### Create a new dataframe from surveys data that meets following criteria: contains only the species_id column and a new column called hindfoot_half containing values that are half the hindfoot_length values; in this new column, there are no NAs and all values are less than 30. Name this dataframe surveys_hindfoot_half   ###

surveys_hindfoot_half <- surveys %>%
  filter(!is.na(hindfoot_length)) %>%
  mutate(hindfoot_half = hindfoot_length / 2) %>%
  filter(hindfoot_half < 30) %>%
  select(species_id, hindfoot_half)


str(surveys_hindfoot_half)  
summary(surveys_hindfoot_half)



### 1. Use group_by() and summarize() to find the mean min and max hindfoot length for each spp (using spp id)

surveys %>%
  group_by(species_id) %>%
  filter(!is.na(hindfoot_length)) %>%
  summarize(avg_hindfoot = mean(hindfoot_length, na.rm = T), max_hindfoot = max(hindfoot_length, na.rm = F), min_hindfoot = min(hindfoot_length, na.rm = F)) 



### 2. What was the heaviest animal measured in each year? Return the columns year, genus, species id, and weight

surveys %>%
  group_by(year) %>%
  filter(!is.na(weight)) %>%
  select(year, genus, species_id, weight) %>%
  summarize(max_weight = max(weight))



### 3. You saw above how to count the # of individuals of each sex using a combo of group_by() and tally(). How could you get the same result using group_by() and summarize?


surveys %>%
  group_by(sex) %>%
  summarize(n = n())



