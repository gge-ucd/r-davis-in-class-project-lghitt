library(tidyverse)

surveys <- read_csv('data/portal_data_joined.csv')


### Conditional Statements ###


# If else function (covered in week5_notes script)

# Case when function

surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_cat = case_when(weight > mean(weight) ~ "big", 
                                weight < mean(weight) ~ "small")) %>% 
  select(weight, weight_cat) %>% 
  tail()


### Challenge ###


data(iris)

summary(iris$Petal.Length)
# min=1, 1st Q=1.6, Med=4.35, avg=3.78, 3rd Q=5.1, max=6.9
new_iris <- iris %>% 
  mutate(petal_length_cat = case_when(Petal.Length <= 1.6 ~ "small",
                                      Petal.Length > 1.6 & Petal.Length < 5.1 ~ "medium",
                                      Petal.Length >=5.1 ~ "large")) %>% 
  mutate(petal_length_cat_2 = ifelse(Petal.Length <= 1.6, "small",
                                     ifelse(Petal.Length >= 5.1, "large",
                                            "medium")))
new_iris



### Merges, Joins ###

tail <- read_csv("data/tail_length.csv")

str(tail)
str(surveys)

intersect(colnames(surveys), colnames(tail))

inner_joined <- inner_join(surveys, tail, by="record_id")
left_joined <- left_join(surveys, tail, by="record_id")
right_joined <- left_join(tail, surveys, by="record_id")
full_joined <- full_join(surveys, tail, by="record_id")

str(inner_joined)


### Pivots ###

?n_distinct

surveys_pivotpractice <- surveys %>% 
  group_by(year, plot_id) %>% 
  count(genus)

surveys_pivotpractice2 <- surveys %>% 
  group_by(plot_id, year) %>% 
  summarize(distinct_genus = n_distinct(genus))


pivot_wider(surveys_pivotpractice2, names_from = "year", values_from = "distinct_genus")

