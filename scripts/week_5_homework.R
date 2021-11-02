library(tidyverse)

surveys <- read_csv('data/portal_data_joined.csv')


### Question 1 ###

#new dataframe (surveys wide)
#Each row lists a genus, then the mean hindfoot length value for every plot type for this genus
# sort dataframe by values in the control plot type column

surveys_wide <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(genus, plot_type) %>% 
  summarize(mean_hindfoot = mean(hindfoot_length)) %>% 
  pivot_wider(names_from = "plot_type", values_from = 'mean_hindfoot') %>% 
  arrange(desc(Control))


### Question 2 ###
#use original surveys dataframe
#create new weight category variable (weight_cat) using 2 different methods: case_when() and ifelse()
#weight_cat should be defined by 3 categories: 'small' is less than or equal to 1st Quartile; 'medium' is between 1st and 3rd quartiles (non-inclusive), 'large' is greater than or equal to 3rd quartile
#assess how these 2 methods treat NA values

summary(surveys$weight)
#min=4.0, 1st Q=20, med=37, avg=42.67, 3rd Q=48, max=280

surveys_weight_cat1 <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_cat1 <- case_when(weight <= 20 ~ "small",
                                  weight > 20 & weight < 48 ~ "medium", 
                                  weight >= 48 ~ "large"))


surveys_weight_cat2 <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_cat2 <- ifelse(weight <= 20, "small",
                               ifelse(weight >= 48, "large",
                                      "medium")))

# ifelse and casewhen returned the same number of observations because I filtered out the NAs prior to manipulating the weight values; doing the same thing again without filtering out NAs:

surveys_weight_cat_1b <- surveys %>% 
  mutate(weight_cat1 <- case_when(weight <= 20 ~ "small",
                                  weight > 20 & weight < 48 ~ "medium", 
                                  weight >= 48 ~ "large"))

surveys_weight_cat_2b <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_cat2 <- ifelse(weight <= 20, "small",
                               ifelse(weight >= 48, "large",
                                      "medium")))

#casewhen returned 34786 observations while ifelse returned 32283 observations

# beware! For casewhen, one option for the final argument is to just have T ~ "large"  if you use this method, this means that all NA values will be grouped into this final argument as well as whatever cases do not meet the criteria of the other specified arguments!


# Bonus

#yeah, I have no clue. Maybe with more dedicated Googling I could come up with something on my own but I'm running low on time this week :(

