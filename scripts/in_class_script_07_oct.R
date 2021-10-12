# wide data  vs  long data; tends to come up in time series
# basically, it comes down to: is each event a new row or a new column?

# reading in spreadsheets
surveys <- read.csv('data/portal_data_joined.csv')


#check out the data
head(surveys)
head(surveys, 50)

str(surveys)

levels(factor(surveys$species))
unique (surveys$species)
sum(!duplicated(surveys$species))

### Challenge ###
#What is the class of the object surveys? A: It's a dataframe
#How many rows and columns in this object? A: 13 columns, 34,786 rows
#How are our character data represented in this data frame? A: chr
#How many species have been recorded during these surveys? A: 40 species

str(surveys)
class(surveys$species)

# Subsetting from a dataframe
surveys[1,2] #row 1, column 2

### Challenge ###
surveys_200 <- surveys[200,] #Challenge question 1
surveys_last <- tail(surveys, 1) # challenge question 2
nrow(surveys) #A: 34,786
surveys_middle <- surveys[17393,] #challenge question 3
surveys_middle_alt <- surveys[nrow(surveys) / 2,] #challenge question 3 alt
surveys_replicate_head <- surveys[-(7:nrow(surveys)),] #challenge question 4







