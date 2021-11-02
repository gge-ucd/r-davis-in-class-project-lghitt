### Intro to ggplot ###



library(tidyverse)

surveys <- read_csv('data/portal_data_joined.csv')

surveys_complete <- surveys %>% 
  filter(complete.cases(.))


### Challenge: Scatterplots ###
# Use what you just learned to create a scatter plot of weight and species_id with weight on the y-axis and species id on the x-axis. Have the colors be coded by plot type. Is this a good way to show this type of data? What might be a better graph?

scatter_challenge <- ggplot(data = surveys_complete, mapping = aes(x=species_id, y=weight)) + geom_point(mapping = aes(color = plot_type)) +
  theme_classic()
scatter_challenge

#use facet function to pop each plot type out into its own frame; this will make the data much more readable and less on top of each other

scatter_challenge_nicer <- ggplot(surveys_complete, aes(x=species_id, y=weight)) + 
  geom_point() + 
  facet_wrap(~plot_type) +
  theme_classic()
scatter_challenge_nicer



### Challenge: Boxplots ###

#1: An alternative to the boxplot is the violoin plot, where the shape (or density of points) is drawn. Replace the boxplot with a violin plot using geom_violin()

#for reference, the original boxplot from the lesson:
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) + 
  geom_boxplot() +
  theme_classic()
boxplot_challenge_1
#with jittering: 
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) + 
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, color = "tomato") + 
  theme_classic()

boxplot_challenge_1 <- ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) + 
  geom_violin(alpha = 0) +
  theme_classic()
boxplot_challenge_1

# 2: Change the scale of the axes to make the plot more readable. Represent weight on the log10 scale using scale_y_log10()

boxplot_challenge_2 <- ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) + 
  geom_violin(alpha = 0) + scale_y_log10() +
  theme_classic()
boxplot_challenge_2

# 3: Make a new plot to explore the distribution of hindfoot_length just for species NL and PF. Overlay a jitter plot of the hindfoot lengths of each species by a boxplot. Then color the datapoints according to the plot from which the sample was taken. 
# Hint: check the class for plot_id. consider changing the classs of plot_id from integer to factor. Why does this change how R makes the graph?

subset_NL_PF <- surveys_complete %>%
  filter(species_id == "NL" | species_id == "PF")
  
subset_NL_PF$plotfactor <- as.factor(subset_NL_PF$plot_id)
  
boxplot_challenge_3 <- ggplot(data = subset_NL_PF, mapping = aes(x = species_id, y = hindfoot_length)) + 
  geom_boxplot() +
  geom_jitter(mapping = aes(color = plotfactor)) +
  theme_classic()
boxplot_challenge_3


new_NLPF_subset <- surveys_complete %>%
  filter(species_id == "NL" | species_id == "PF") %>% 
  mutate(plot_factor <- as.factor(plot_id)) %>% 
  ggplot(mapping = aes(x = species_id, y=hindfoot_length)) +
  geom_boxplot(alpha = 0.1) +
  geom_jitter(alpha = 0.3, mapping = aes(color = plot_id)) + 
  theme_classic()
new_NLPF_subset


### THIS WAY IS BETTER BECAUSE THE FACTOR IS TEMPORARY ###
new_NLPF_subset_2 <- surveys_complete %>%
  filter(species_id == "NL" | species_id == "PF") %>% 
  ggplot(mapping = aes(x = species_id, y=hindfoot_length)) +
  geom_boxplot(alpha = 0.1) +
  geom_jitter(alpha = 0.3, mapping = aes(color = as.factor(plot_id))) + 
  theme_classic()
new_NLPF_subset_2


### fun things to know in ggplot

# Labels
labeltime <- surveys_complete %>%
  filter(species_id == "NL" | species_id == "PF") %>% 
  ggplot(mapping = aes(x = species_id, y=hindfoot_length)) +
  geom_boxplot(alpha = 0.1) +
  geom_jitter(alpha = 0.3, mapping = aes(color = as.factor(plot_id))) + 
  labs(x = "Species ID", 
       y = "Hindfoot Length",
       title = "Boxplot",
       color = "Plot ID") +
  theme_classic()

labeltime


