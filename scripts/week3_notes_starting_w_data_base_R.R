# Starting with Data (Base R)

### GOALS ###
# how to get data into R and inspect it using some base R functions

# using read.csv() function to read in data, and explore and subset datframes

#packages & base R (see script week3_notes_starting_w_data_tidyverse for tidyverse)

### Reading in Data ###

surveys <- read.csv('data/portal_data_joined.csv')

### Inspecting the data ###
nrow(surveys) #tells you the number of rows in the data; 34,786 in this case
ncol(surveys) #tells you the number of columns in the data; 13 in this case

class(surveys) #what kind of data is this? "aata.frame"

head(surveys) #look at the top entries; lists first 6 rows
tail(surveys) #look at the bottom entries; lists last 6 rows

# to look at the data in its entireity, two options: go to 'Environment' pane and click on the name of the data frame to open it in a new tab, OR:
View(surveys) #note the capital V in View! This function also opens the dataframe in a new window

str(surveys) #tells you it's a dataframe with X many dimensions, lists the columns, data type for each column, lists off the first few entries for each column

summary(surveys) #summarizes each column; for integers, gives min, max, quartiles, median, mean; for character vectors, doesn't give you really anything

#indexing in a dataframe: 

#inside the brackets, row comes before column: [row, column]
surveys[1,1]
surveys[1,6]
surveys[,6] #spits out every item in column 6; extracts a vector; confirm with:
class(surveys[,6]) #output: "character"

surveys[6] #spits out every item in column 6, but maintained as a dataframe; confirm with
class(surveys[6]) #output: "data.frame"

#Special signs for subsetting: colon (:) presents a range; negative sign (-) subtracts

surveys[1:6,] #shows me rows 1-6
surveys[-(1:6),] # use parentheses to exclude entries; this example excludes records 1-6

### subsetting with column name ###

colnames(surveys) #tells you the names of all the columns in your dataframe
surveys["species_id"]#specify the column name you want to pull out using quotation marks; output is all the data stored in the column species ID, presented as a dataframe
surveys[,"species_id"] #this approach outputs all the data stored in the column species ID, presented as a vector

### Preferred method of subsetting w/ $ character ###

surveys$species_id #be aware: output is a vector
