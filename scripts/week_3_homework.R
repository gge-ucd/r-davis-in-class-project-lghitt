library("tidyverse") #packages should go at the top of a script

surveys <- read.csv('data/portal_data_joined.csv')


### Create new dataframe with only first 60 rows and only columns species_id, weight, and plot type ###
surveys_60 <- head(surveys, 60)

surveys_base <- select (surveys_60, species_id, weight, plot_type)
#alternate: surveys_base <- surveys [c('species_id', 'weight', 'plot_type')]
# alternate w piping: surveys %>% select(species_id, weight, plot_type)
surveys_base_2 <- surveys[c(1:60), c(6,9,13)]
surveys_base_2 %>% str()


### Convert species_id and plot_type to factors ###
?factor

surveys_base$species_id_factor <- factor(surveys_base$species_id)
surveys_base$plot_type_factor <- factor(surveys_base$plot_type)
# I chose to create new columns for the factor-ized data rather than convert the original

str(surveys_base) # double-check that the new columns are columns


### Remove all observations with a NA in the weight column ###

surveys_base_no_nas <- surveys_base [na.omit(surveys_base$weight)]
no_nas_surveys <- surveys_base %>% na.omit(surveys_base$weight)


### Challenge: create a new dataframe that consists only of individuals from the surveys_base dataframe with weights greater than 150g ###

challenge_base <- surveys_base[which(surveys_base$weight > 150),]
