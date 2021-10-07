### Loading and working with the tidyverse ###

#install.packages("tidyverse") #this command installs packages
#Yes
#only have to install packages once but you do have to load packages into the library for every new session
library(tidyverse)

#tidyverse likes working with tibbles rather than dataframes

surveys_t <- read_csv("data/portal_data_joined.csv")
surveys_t #this is a tibble; its output is 10 rows, it tells us data types for each column, autofills blanks in data with bright-red NA values
surveys #this is a dataframe

class(surveys_t) #not sure what this did

#subsetting is different for tibbles vs dataframes:
surveys[,1] #gives us a vector
surveys_t[,1] #gives us a tibble (more readable)




