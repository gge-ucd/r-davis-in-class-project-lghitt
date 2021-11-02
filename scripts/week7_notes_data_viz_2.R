### This week: Best practices (e.g., color, aesthetics), non-visual methods of data presentation (accessability), how to fine-tune plot appearances, how to save plots, how to save multiple plots in one common plot window

library(tidyverse)
data(mtcars)

str(mtcars)

# when making visuals, less is more! 
#Edward tufte: resource on data visualization best practices

library(ggthemes)
library(ggplot2)

plot1 <- ggplot(data = mtcars, aes(x = mpg, y= hp)) + 
  geom_point()
plot1
plot2 <- ggplot(data = mtcars, aes(x = mpg, y= hp)) + 
  geom_point() +
  theme_tufte()
plot2

#make sure colors are accessible and will pop when printed in black and white

install.packages("gridExtra")

library(gridExtra)
grid.arrange(plot1, plot2, ncol=2)

plot3 <- ggplot(data = mtcars, aes(x=mpg, y=hp, color=as.factor(cyl))) +
  geom_point() +
  scale_color_colorblind()
plot3

plot4 <- ggplot(data = mtcars, aes(x=mpg, y=hp, color=wt)) +
  geom_point() +
  theme_bw() + 
  scale_color_viridis_c(option = "B") #viridis_c = continuous; viridis_d = discrete; option B specifies 'inferno; color palette which is pretty cool
plot4

install.packages("tigris")
library(tigris)

ga_counties = tigris::counties(state = 'GA', class = 'sf', year=2017)
library(sf)
gaplot <- ggplot(data = ga_counties) + 
  geom_sf(data = ga_counties, aes(fill = ALAND)) +
  theme_map() +
  scale_fill_viridis_c()
gaplot #pretty! Only problem is the scale bar for the chloropleth map imposed on top of some of the dataframe?

### non-visual methods of data presentation & visualization

install.packages("BrailleR")
library(BrailleR)

barplot <- ggplot(diamonds, aes(x=clarity, fill=cut)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle=70, vjust=0.5)) +
  scale_fill_viridis_d(option="C") +
  theme_classic()
barplot  

BrailleR::VI(barplot)

install.packages('sonify')
library(sonify)

plot(iris$Petal.Width)
sonify(iris$Petal.Width) #whoa

sonify(x=iris$Petal.Width, y=iris$Petal.Length) #WHOAAAA



### Part 2: How to combine multiple plots into a single aggregate plot object, plus tips on saving and interactive plots

summary(diamonds)
summary(iris)
summary(mpg)

diamonds.plot <- ggplot(diamonds, aes(clarity, fill=cut)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5)) 
diamonds.plot

mpg.plot <- ggplot(mpg, aes(cty, hwy, color = factor(cyl))) +
  geom_point(size=2.5)
mpg.plot

iris.plot <- ggplot(iris, aes(Sepal.Length, Petal.Length, color=Species)) +
  geom_point(alpha=0.3)
iris.plot

#cowplot package to combine many plots
#install.packages('cowplot')
library(cowplot)

# plot_grid lines up many plots in even boxes
plot_grid(diamonds.plot, iris.plot, mpg.plot, labels = c("A", "B", "C"), nrow=1)

# ggdraw function added to draw_plot lines up plots
# kind of like a metaplot?
final.plot <- ggdraw() + 
  draw_plot(iris.plot, x=0, y=0, width=1, height=0.5) + 
  #iris will take up whole bottom of row
  draw_plot(mpg.plot, x=0, y=0.5, height=0.5, width=0.5) +
  #mpg will take up top left
  draw_plot(diamonds.plot, x=0.5, y=0.5, width=0.5, height=0.5)
#diamonds is top right
  
# other options to do this same meta-graphing idea include:  grid_arrange (see line 27 of this code) and patchwork


### Saving plots with ggsave
getwd()
dir.create("figures")
ggsave("figures/finalplot.png", plot = final.plot, width = 6, height = 4, units = "in")



### Interactive plots w/ plotly
install.packages("plotly")
library(plotly)
ggplotly(iris.plot)



