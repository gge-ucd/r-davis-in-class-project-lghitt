### Iteration ###
# For loops and map functions

# a reminder of how to index values



head(iris)
head(mtcars)

iris[1] #spits out 1st column for every observation in list form
iris[[1]] # returns 1st column for every observation in vector form
iris$Sepal.Length #same
iris[,1] #same
iris[1,1] #value of first row and first column
iris$Sepal.Length[1] #calls upon first row/observation from specified column



### For loops ###
#takes an index value (i) and for every value of i, runs whatever functions are specified in {}

## just made a discovery: with these for loops, it matters where your cursor is when you try to run the code; run it from the top, not from wherever you typed last!


for(i in 1:10){
  print(i)
}

i # R stores the last value, so currently output is 10

for(i in 1:10) {
  print(iris$Sepal.Length[i])
}
head(iris$Sepal.Length, n=10)


for(i in 1:10){
  print(iris$Sepal.Length[i])
  print(mtcars$mpg[i])
}

# store output: first step is to create an empty 'vessel', then fill it with the for loop and its functions/outputs

results <- rep(NA, nrow(mtcars)) #rep = replicate/repeat
results #returns a bunch of NAs


for(i in 1:nrow(mtcars)){
  results[i] <- mtcars$wt[i]*100
}
results #resturns actual data, in vector format
mtcars$wt

i

### Map family of functions ###
# tidyverse's apply functions
#map takes an input and a function argument

library(tidyverse)
map(iris, mean) #output spits out avgs for each column in a list; has error message; doesn't know what to do with non-numeric values that it can't create averages for
map_df(iris, mean) # output returns a tibble; same error message because it doesn't know how to take the mean for a species
map_df(iris[1:4], mean) #output is a tibble

# mapping with 2 arguments with a pre-written function
mtcars
print_mpg <- function(x,y){
  paste(x, "gets", y, "miles per gallon")
}

map2_chr(rownames(mtcars), mtcars$mpg, print_mpg)


#mapping with 2 arguments with an embedded "anonymous" function

map2_chr(rownames(mtcars), mtcars$mpg, function(x,y) paste(x, "gets", y, "miles per gallon"))

