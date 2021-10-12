library("tidyverse")

surveys <- read.csv('data/portal_data_joined.csv')


### Create new dataframe with only first 60 rows and only columns species_id, weight, and plot type ###
surveys_60 <- head(surveys, 60)

surveys_base <- select (surveys_60, species_id, weight, plot_type)


### Convert species_id and plot_type to factors ###
?factor

surveys_base$species_id_factor <- factor(surveys_base$species_id)
surveys_base$plot_type_factor <- factor(surveys_base$plot_type)
# I chose to create new columns for the factor-ized data rather than convert the original

str(surveys_base) # double-check that the new columns are columns


### Remove all pbservations with a NA in the weight column ###

surveys_base_no_nas <- na.omit(surveys_base)

### Challenge: create a new dataframe that consists only of individuals from the surveys_base dataframe with weights greater than 150g ###

challenge_base <- surveys_base[which(surveys_base$weight > 150),]
