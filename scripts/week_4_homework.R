library(tidyverse)

### Question 1 ###
surveys <- read_csv('data/portal_data_joined.csv')


### Question 2 ###
surveys_weight_range <- surveys %>%
  filter(!is.na(weight)) %>%
  filter(weight >30, weight <60)
head(surveys_weight_range)  


### Question 3 ###
biggest_critters <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>%
  summarize(max_weight = max(weight), min_weight = min(weight))
biggest_critters


### Question 4 ###

surveys_nas_by_plot <- surveys %>% 
  group_by(plot_id) %>%
  filter(is.na(weight)) %>%
  tally()
arrange(surveys_nas_by_plot, desc(n)) #plots 13, 15, 14, and 20 have most NAs

surveys_nas_by_spp <- surveys %>%
  group_by(species_id) %>%
  filter(is.na(weight)) %>%
  tally()
arrange(surveys_nas_by_spp, desc(n)) #spp AH has most NAs by far, followed by DM & AB

surveys_nas_by_year <- surveys %>%
  group_by(year) %>%
  filter(is.na(weight)) %>%
  tally()
arrange(surveys_nas_by_year, desc(n)) #Most NAs in 1977, followed by 98, 87, 88, 78


### Question 5 ###

surveys_avg_weight <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>%
  mutate(avg_weight = mean(weight)) %>%
  select(species_id, sex, weight, avg_weight)
surveys_avg_weight


### Question 6 ###

surveys_avg_weight %>%
  mutate(above_average = ifelse(weight > avg_weight, 'above', 'below'))

