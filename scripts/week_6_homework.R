library(tidyverse)

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

str(gapminder)


### Question 1

#Calculate mean life expectancy on each continent. Then create a plot that shows how life expectancy has changed over time in each continent. Try to do this all in one step using pipes

q1_plot <- gapminder %>%
  filter(complete.cases(.)) %>%
  group_by(continent, year) %>%
  summarize(mean_lifeExp = mean(lifeExp))%>%
  ggplot(mapping = aes(x=year, y=mean_lifeExp)) + 
  geom_line(mapping = aes(color=continent)) + 
  theme_classic() +
  scale_color_viridis_d()
q1_plot



### Question 2

# Look at the following code and answer the following questions: 
q2_plot <- ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) +
  geom_point(aes(color=continent), size = .25) +
  scale_x_log10() + 
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()
q2_plot
#Question 2A:
#What do you think the scale_x_log10() line of code does?
      #the scale_x_log10() line of code transforms the GDP per capita values for each observation by log-base10. If you take this line of code away, the graph becomes very difficult to read: the vast majority of the datapoints are concentrated within one-quarter of the graph's area, and a few very very dramatic outliers take up the rest of the graph. Log-transforming this data using the scale_x_log10 function collapses down the values so that the outliers are not as dramatically separated from the graph, making the rest of the data easier to read but understating the dramatic difference between the majority of the data and the outliers.

#Question 2B:
#What do you think the geom_smooth() line of code does?
      # the geom_smooth() line of code adds a trendline to the data; this function allows you to specify what kind of trendline to add (linear, quadratic, etc) and other components of the trendline's appearance

#Challenge: Modify the above code to size the points in proportion to the population of the country (Hint: are you translating data to a visual feature of the plot?)
q2challenge_plot <- ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) +
  geom_point(aes(color=continent, size=pop)) +
  scale_x_log10() + 
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()
q2challenge_plot 
#ugly but it happened!




### Question 3

#Create a boxplot that shows the life expectancy for Brazil, China, El Salvador, Niger, and the United States, with the data points in the background using the geom_jitter. Label the X and Y axes with "Country" and "Life Expectancy" and title the plot "Life Expectancy of Five Countries"

q3_plot <- gapminder %>% 
  filter(country== "Niger" | country =="China" | country == "Brazil" | country=="El Salvador" | country=="United States") %>% 
  ggplot(mapping = aes(x = country, y = lifeExp)) +
  geom_boxplot() +
  geom_jitter(mapping = aes(color = gdpPercap)) + 
  theme_classic() +
  labs(x = "Country",
       y = "Life Expectancy",
       title = "Life Expectancy of Five Countries") +
  scale_color_viridis_c()
q3_plot
