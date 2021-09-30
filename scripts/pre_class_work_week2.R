c(1,2)
simpleVector = c(1)
notSoSimpleVector = c(1, 'test', 2, 'other string')

animals <- c("mouse", "rat", "dog")
weight_g <- c(50, 60, 65, 82, 95)
length(weight_g)
length(animals)

class(weight_g)
class(animals)

NewVector = c(1,2,'not_a_number')
class(NewVector)

str(weight_g)
weight_g
str(animals) 
animals[2]
animals[c(3,2)]

weight_g[c(TRUE, FALSE, TRUE, TRUE, FALSE)]
weght_g>30
weight_g[weight_g>30]

{r, results='show,' purl=FALSE}
weight_g[weight_g <30 | weight_g > 50]
weight_g[weight_g >=30 & weight_g == 2]


rat = animals[2]
animals[c(1,2,3,2,1,4)]

weight_g



x <- 1:10
10:1
x * 1:10

heights <- c(2, 4, 4, NA, 6)
mean(heights)
max(heights)
mean(heights, na.rm = T)
max(heights, na.rm = TRUE)

table(is.na(heights))
is.na(heights)
