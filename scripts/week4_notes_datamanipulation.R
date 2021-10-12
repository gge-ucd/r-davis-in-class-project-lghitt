### How to do things with data you've read in: selecting, making new columns, manipulating data ###
# review on installing packages at the end of this script

library(tidyverse)

surveys <- read_csv('data/portal_data_joined.csv') #read.csv accomplishes the same task; example of tidyverse and base R functions that accomplish the same thing
dim(surveys) #dim = dimensions



### Select ###
# grabs COLUMNS you want from the dataframe

select(surveys) #nothing happened; a dataframe of 0 columns, which makes no sense
select(data = surveys, sex, weight, genus) #anything that comes after the first data object is supposed to be a column name
head(select(surveys,sex,weight,genus))



### Filter ###
# selects ROWS you want from the dataframe
# provide rules with R to sort against; e.g., where sex = F

head(filter(surveys,genus=='Neotoma')) #needs a CONDITIONAL statement
head(filter(surveys,genus!='Neotoma'))



### Pipes ###
# can perform multiple functions (sorting and filtering) in the same command

#the long way:
surveys2 <- filter(surveys, genus != 'Neotoma')
surveys3 <- select(surveys2, genus, sex, species)

#the short way (nesting functions):
surveys_filtered <- select(filter(surveys, genus != 'Neotoma'),genus,sex,species) # R starts from the middle of any nested function and works outward

identical(surveys3, surveys_filtered) #Doublechecked that our nested function accomplished the same result as the 'long way;' Output = TRUE so the pipe function did what it was supposed to

#special character: %>% 'pipe' from magrittr package, strings together selection and filtering values; takes whatever feeds in and inserts it into the next line of whatever you call (so any subsequent functions do NOT need the dataframe specified)
  
surveys_filtered_again <- surveys %>%
  filter(genus!= 'Neotoma') %>% select(genus,sex,species)

str(surveys_filtered_again)
identical(surveys_filtered, surveys_filtered_again)



### Mutate function ###
#allows you to create a new column in a dataframe or alter an existing column

surveys <- surveys %>% mutate(weight_kg = weight/1000)#creates a new column and converts grams to kg

#alternate mutate method without piping
mutate(surveys, weight_kg = weight/1000)



### Group_by function ###

surveys_new <- read.csv('data/portal_data_joined.csv')
str(surveys_new)

surveys_new %>% group_by(sex)
#returns the same dataframe w additional notation stating what you grouped the dataframe by
surveys_new %>% group_by(sex) %>% summarize(weight) #didn't work because we asked it to compute weight by sex but didn't give it a function to summarize by; fix below:
surveys_new %>% group_by(sex) %>% summarize(mean(weight)) #new problem: the mean function in R doesn't know how to handle NA values, so we need to specify what to do with them; fix below:
surveys_new %>% group_by(sex) %>% summarize(mean(weight, na.rm = T)) #removes any NA values then runs the mean; but the output has a weird name; fix below
surveys_new %>% group_by(sex) %>% summarize(avg_weight = mean(weight, na.rm = T)) #same thing, but with a pretty title in the output instead of the original function call


surveys_new %>% group_by(sex) %>%
  summarize(avg_weight = mean(weight, na.rm = T), med_weight = median(weight, na.rm = T))



### Tally Function ###
#count function; tells you the number of observations for a given group

surveys_new %>% group_by(sex) %>% tally()




### Packages: Installing and loading ###

# package = set of functions someone built, that you can load into your R environment and then use; standardized and regular approach to access functions other people have made
#can be stored on GitHub and downloaded from people's repositories, but the standard method is to store packages in CRAN
installed.packages()

# to install package: install.packages('') (name of package goes in '')
# to load package into your environment: library() (name of package in parentheses)

install.packages('lubridate')
library(lubridate)