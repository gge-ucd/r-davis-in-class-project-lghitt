library(tidyverse)

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

gapminder2 <- gapminder %>% 
  filter(continent != "Oceania") %>% 
  group_by(continent, country)%>% 
  select(country, continent, year, pop)%>%
  filter(year == 2002 | year == 2007) %>% 
  pivot_wider(names_from = "year", values_from = "pop")

colnames(gapminder2) <- c("country", "continent", "X2002", "X2007")

gapminder2 <- mutate(gapminder2$pop_change <- (gapminder2$X2007 - gapminder2$X2002))

# received this error message: Error in UseMethod("mutate") : 
# no applicable method for 'mutate' applied to an object of class "c('double', 'numeric')"
# but the function seemed to work anyway?? New column pop_change *seems* to have calculated correctly?

#Originially tried filtering out the Oceania entries after pivoting wider but received error message that "object 'continent' not found," but after moving it into my first pipeline (above) the exact same function worked just fine?




hw_plot1 <- ggplot(data = gapminder2, mapping = aes(x = reorder(country, pop_change), y = pop_change)) + 
  geom_col(mapping = aes(fill= continent)) + 
  facet_wrap(~continent, scales = "free") + 
  scale_x_reordered() +
  theme_classic() + 
  scale_fill_viridis_d() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none") + 
  xlab("Country") + 
  ylab("Change in Population Between 2002 and 2007")
hw_plot1


# I was curious to see what the data would look like when log transformed, since the most striking takeaway from the original graph was how dramatic the outliers with extreme population growth are compared to other countries with slower/stagnant growth; log transforming the y-axis made the outliers less dramatic and omitted countries that observed 0 or negative population change (especially notable for the Europe graph since several countries had population decreases between 2002 and 2007)
hw_plot_experimenting <- ggplot(data = gapminder2, mapping = aes(x = reorder(country, pop_change), y = pop_change)) + 
  geom_col(mapping = aes(fill= continent)) + 
  facet_wrap(~continent, scales = "free") + 
  scale_x_reordered() +
  scale_y_log10() +
  theme_classic() + 
  scale_fill_viridis_d() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none") + 
  xlab("Country") + 
  ylab("Change in Population Between 2002 and 2007")
hw_plot_experimenting

