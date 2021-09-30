a <- 1
a <- 2

letters


### Vector = collection of things tied to something named in R ###

(number_vector <- c(12, 3, 92))

### indexing (the brackets [] ) is a way of re-copying values; what do you want R to show you?   ###

number_vector[2]

number_vector[c(2,2)] # output: [1] 3 3 

number_vector[c(3, 2, 1)] #output: [1] 92  3 12

number_vector = c(number_vector, 54) ### to add something to your vector
number_vector #output: [1] 12  3 92 54

### strings are letters in R; to encode them, put them in "" or '', without these denominators, R will read any letters as potential commands and will be confused if it doesn't find them

#make a vector with strings:
string_vector <- c("hippo", "giraffe", "lion") #output: tring_vector <- c("hippo", "giraffe", "lion")

#can make R code numbers as strings by placing them in quotes!
number_as_string <- "24" #output: number_as_string <- "24"
number_as_numeric <- 24 #output: number_as_numeric <- 24


# use ? to get R to tell you what a given function means/does

? str()
? class

class(number_as_string) #output: [1] "character"
class(number_as_numeric) #output: [1] "numeric"

string_vector
data.frame(string_vector) #output:   string_vector 1  hippo 2 giraffe 3  lion
class(string_vector) #output: [1] "character"

data.frame(c(string_vector, string_vector))

data.frame(first_column = string_vector, second_column = string_vector)

#check out this error: 
data.frame(first_column = string_vector, second_column = c(string_vector, '23')) #output: arguments imply differing number of rows: 3, 4 
# when you tell R it's a data frame, R assumes each column has the same # of values

test_list = list('first string entry into list')

str(test_list)
test_list[1][[1]]

list2 = list('flour')
list2 [2] = "sugar"
list2

list3 = list('flour')
str(list3)
list3[[1]][2] <- 'sugar'
list3

test_df <- data.frame(letters, letters)
list3[[3]] <- test_df
str(list3)
list3[[2]] #output: NULL


### LEARNING OBJECTIVES: how to make vectors, data frames, & lists
### how to pull things out of vectors, data frames, & lists
### how to add vectors, data frames, & lists to one another


