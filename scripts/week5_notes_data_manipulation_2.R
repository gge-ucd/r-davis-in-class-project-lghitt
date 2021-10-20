### Conditional statements ###
### if, then functionality ###
### joining dataframes ###
### wide vs long dataframes, and changing them back and forth ###

library(tidyverse)


surveys <- read_csv('data/portal_data_joined.csv')
str(surveys) #shows us column names, variable types, # of rows & columns


### Conditional assignment ###


summary(surveys$hindfoot_length)

### create a new variable that groups these observations by large, small
#anything below mean classified as 'small', anything above mean classified as 'large'
#3 parts: test, two responses: what to do with yeses, what do do with nos
ifelse(surveys$hindfoot_length<mean(surveys$hindfoot_length, na.rm=T), 'small', 'big') 

surveys <- mutate(surveys, hindfoot_size = ifelse(surveys$hindfoot_length<mean(surveys$hindfoot_length, na.rm=T), 'small', 'big') )

surveys$hindfoot_size

#tidyverse version of ifelse: case_when() function (doesn't handle NAs very well)


### Joining Dataframes ###

tail <- read_csv('data/tail_length.csv')
str(tail)
summary(tail$record_id)
summary(surveys$record_id)

# joins! 
# inner join = only cases that match for both dataframe A & B
# left/right join = return everything in table A + cases from B that have a match in A; everything in B that doesn't match table A is coded as NA (and vice-versa)
# full join = returns everything; assign NAs for every variable where a value isn't observed in the other table
# we won't talk about many:many or one:many joins yet. Too messy.

surveys_joined <- left_join(surveys, tail, by = "record_id")
str(surveys_joined)

left_join(survey, tail) # join still works without specifying common identifiers to base join on; program *can* figure out identical columns, but might not be wise because it could make some incorrect assumptions about which column you want to join on


### Reshaping ###
surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>%
  group_by(genus, plot_id) %>%
  summarize(mean_weight = mean(weight))
surveys_mz
unique(surveys_mz$genus)
n_distinct(surveys_mz$genus)

wide_survey <- pivot_wider(surveys_mz, names_from = 'plot_id', values_from = 'mean_weight')
dim(wide_survey)
str(wide_survey)

pivot_longer(wide_survey, -genus, names_to = 'plot_id', values_to = 'mean_weight') %>% head()


