### Week 2 Homework ###

set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2 #output has 4 NAs


### Problem 1 ###


practiceprob1 <- hw2[is.na(hw2)]
practiceprob1 #practicing pulling out NA values into a new vector

prob1 <- hw2[!is.na(hw2)] #creates a new vector ('prob1') which pulls from hw2 all the values that are NOT ('!') NAs
prob1 #ran this to prove that the output has no NAs

prob1 <- prob1[prob1 >=14 & prob1 <= 38] #subsetting prob1 so that it only includes numbers between 14-38 inclusive
prob1 #ran this to prove that the output only includes numbers between 14-38; output has 23 values


### Problem 2 ###


practicetimes3 <- prob1 * 3 #this was the practice vector I used/changed a million times while I worked on getting the right answer
practicetimes3 #ran this to see what each command *actually* did

times3 <- prob1 * 3 #takes every value in prob1 and multiplies it by 3
times3 #ran this to prove that the output multiplied every value in prob1 by 3

practiceplus10 <- times3 + 10 #this was the practice vector I used/changed a million times while I worked on getting the right answer
practiceplus10 #ran this to see what each command *actually* did

plus10 <- times3 + 10
plus10 #ran this to prove all the values have had 10 added


### Problem 3 ###


practice_everyother <- plus10[c(TRUE, FALSE)] #practicing subsetting by selecting every other value
practice_everyother #output has 12 values that match the 12 in the assignment instructions

final <- plus10[c(TRUE, FALSE)]
final
