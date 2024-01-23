#install necesarry packages to reproduce paper
install.packages("tidyverse")
install.packages("opendatatoronto")
install.packages("readr")
install.packages("knitr")
install.packages("janitor")
install.packages("ggplot2")
install.packages("testthat")
library(janitor)
library(tidyverse)
library(opendatatoronto)
library(readr)
library(knitr)
library(ggplot2)
library(testthat)

# plot arrest counts by age cohort
ggplot(age_data, aes(x = age_cohort, y = arrest_count)) +
  geom_bar(stat = "identity") +
  labs(title = "Toronto Arrest Counts by Age Cohort",
       x = "Age Cohort", y = "Arrest Count")

# plot arrest count by general location
ggplot(summarized_data, aes(x = area_category, y = arrest_count)) +
  geom_bar(stat = "identity") +
  labs(title = "Toronto Arrest Count by General Location",
       x = "Neighbourhood", y = "Arrest Count")

# plot arrest count by general location and type of crime
ggplot(crime_and_location, aes(x = crime_category, y = arrest_count,
                               fill = area_category)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  labs(title = "Toronto Arrest Count by Crime Category and Location",
       x = "Crime Category", y = "Arrest Count") +
  theme(axis.text.x = element_text(size = 8, angle = 45, hjust = 1))

# plot by Age Cohort and Crime Category
ggplot(crime_and_age, aes(x = age_cohort, y = arrest_count,
                          fill = crime_category)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  labs(title = "2019 Toronto Arrest Count by Crime Category and Age Group",
       x = "Age Group", y = "Arrest Count") +
  theme(axis.text.x = element_text(size = 8, angle = 45, hjust = 1))

# plot census data
census_data <- read_csv("outputs/data/census_data.csv")
ward_hh_income <- census_data |>
  slice(1:26)
kable(census_data, format = "pipe", caption = "Toronto Census Data by Ward")
