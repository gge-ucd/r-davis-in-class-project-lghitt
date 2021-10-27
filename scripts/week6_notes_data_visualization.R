### Data visualization! ggplot2 ! ###

### Scatter plots & boxplots ###

library(tidyverse)

surveys <- read_csv('data/portal_data_joined.csv') %>% 
  filter(complete.cases(.))


# General format: ggplot(data = <DATA>, mapping = aes(<MAPPINGS)) + <GEOM_FUNCTION>() 
# geom_point() for scatter plots (continuous x continuous variables)
# geom_boxplot() for for boxplots (categorical x continuous variables)
# geom_line for trendlines

ggplot(data = surveys) #makes just a blank canvas 'plot'

ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) #makes a blank canvas, but with axes for your x & y variables (data comes from geom function)

ggplot(data = surveys, mapping = aes(x=weight, y=hindfoot_length)) + 
  geom_point()

base_plot <- ggplot(data = surveys, mapping = aes(x=weight, y=hindfoot_length)) 


base_plot + geom_point()

# additional arguments, plot elements: transparency = alpha, color = color, infill = fill

base_plot + geom_point(alpha = 0.2)
base_plot + geom_point(color = "blue")
base_plot + geom_point(colo = "chartreuse") # didn't recognize the color
base_plot + geom_point(alpha = 0.5, color = "red")

# coloring by categories (species_id)

ggplot(data = surveys, mapping = aes(x=weight, y=hindfoot_length)) + 
  geom_point(mapping = aes(color = species_id))

# boxplots!

ggplot(data=surveys, mapping = aes(x = species_id, y=weight)) + geom_boxplot()

base_plot2 <- ggplot(data = surveys, mapping = aes(x=species_id, y=weight))

base_plot2 +
  geom_boxplot(color = "purple") +
  geom_point()

base_plot2 +
  geom_boxplot() + 
  geom_jitter(alpha = 0.2, mapping = aes(color = species_id))


### Part B ###

#time series observation
yearly_counts <- surveys %>%
  count(year, species_id)
str(yearly_counts)

ggplot(data = yearly_counts, aes(x = year, y = n)) + 
  geom_line() # looks bananas

ggplot(data = yearly_counts,
       aes(x=year, y=n, group=species_id)) +
  geom_line()

#faceting: facet_wrap or facet_grid

ggplot(data = yearly_counts, aes(x=year, y=n, group=species_id)) + 
  geom_line() +
  facet_wrap(~species_id) #did something weird?

ggplot(data = yearly_counts, aes(x=year, y=n, group=species_id)) + 
  geom_line() +
  facet_wrap(~species_id, nrow=2) #compresses into 2 rows, puts as many observations into the 2 rows as necessary to fit all the specified data

ggplot(data = yearly_counts, aes(x=year, y=n, group=species_id)) + 
  geom_line() +
  facet_wrap(~species_id, scales = 'free_y') #scales options: fixed (default), free (varies to more viewable size), free_x (free in 1 dimension), free_y = free in other dimension)


### Setting themes in ggplot ###

ggplot(data = yearly_counts, aes(x=year, y=n, group=species_id)) + 
  geom_line() +
  facet_wrap(~species_id) +
  theme(plot.background = element_rect(fill='black'))
#black border/background surrounding plot

ggplot(data = yearly_counts, aes(x=year, y=n, group=species_id)) + 
  geom_line() +
  facet_wrap(~species_id) +
  theme_classic() #bw, dark, classic, gray (default)

install.packages('ggthemes')

library(ggthemes)

# fun stuff

ggplot(data = yearly_counts, aes(x=year, y=n, group=species_id)) + 
  geom_line() +
  facet_wrap(~species_id) +
  theme_map()




