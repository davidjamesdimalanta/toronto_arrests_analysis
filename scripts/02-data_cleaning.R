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

# Cleaning Data using "dplyr" package
raw_arrest_data <- read_csv("inputs/data/raw_arrest_data")
cleaned_arrest_data <- raw_arrest_data |>
  clean_names()

# Renaming Confusing Column Names
cleaned_arrest_data <- cleaned_arrest_data |>
  rename(
    neighbourhood = hood_158,
    crime_neighbourhood = neighbourhood_158,
    crime_category = category
  )
options(scipen = 999)

# save arrest data
write_csv(cleaned_arrest_data, "outputs/data/cleaned_arrest_data.csv")


### Leveraged Code From https://github.com/ThomasWilliamFox/toronto_child_care
# Read and clean 2021 Canada census data

ward_name_data <- read_csv("inputs/data/raw_ward_names.csv")

ward_name_data <-
  clean_names(ward_name_data)

ward_name_data

census_data <- read_csv("inputs/data/raw_census_data.csv")

# Get subset of data covering total population and population under 14 by ward
population_data <- census_data[c(18:21), c(1:27)]

population_data

# Get subset of data covering average/total/and median household incomes by ward
income_data <- census_data[c(1383:1384), c(1:27)]
income_data

# Merges income and population subsets together
census_data_merged <- rbind(population_data, income_data)
census_data_merged

# Transposes x and y axis
cleaned_census_data_temp <- t(census_data_merged)

# Turns matrix from transposing into data frame
cleaned_census_df <-
  as.data.frame(cleaned_census_data_temp)

# Converts data frame to tibble
cleaned_census_data <- tibble(cleaned_census_df)
cleaned_census_data

# Uses first row as names of variables
cleaned_census_data <- cleaned_census_data |>
  row_to_names(row_number = 1)

# Adds column to indicate wards
cleaned_census_data <-
  cleaned_census_data |> add_column(ward = 0:25, .before = "Total - Age")

# Renames first ward "0" to Toronto (City total)
cleaned_census_data <-
  cleaned_census_data |>
  mutate(
    ward = as.character(ward)
  )
cleaned_census_data[cleaned_census_data == 0] <- "Toronto"

# Rename variable names
cleaned_census_data <-
  cleaned_census_data |>
  rename(pop_total = `Total - Age`,
    pop_0_to_4 = `0 to 4 years`,
    pop_5_to_9 = `5 to 9 years`,
    pop_10_to_14 = `10 to 14 years`,
    avg_income = `Average total income of households in 2020 ($)`,
    med_income = `Median total income of households in 2020 ($)`
  )

# Convert all numerical columns to int or num
cleaned_census_data <-
  cleaned_census_data |>
  mutate(
    pop_total = as.integer(pop_total),
    pop_0_to_4 = as.integer(pop_0_to_4),
    pop_5_to_9 = as.integer(pop_5_to_9),
    pop_10_to_14 = as.integer(pop_10_to_14),
    avg_income = as.numeric(avg_hh_income),
    med_income = as.numeric(med_hh_income)
  )


#### Save data ####

# Save cleaned census data
write_csv(cleaned_census_data, "outputs/data/census_data.csv")

# Save cleaned ward name data
write_csv(ward_name_data, "outputs/data/ward_names.csv")

### (END OF LEVERAGED CODE) ###

unique(cleaned_arrest_data$crime_neighbourhood)

# Read the Arrest Count data
cleaned_arrest_data <- read_csv("outputs/data/cleaned_arrest_data.csv")

# sort and export arrest counts by age cohort
age_data <- cleaned_arrest_data |>
  group_by(age_cohort) |>
  summarise(arrest_count = sum(arrest_count, na.rm = TRUE))

write_csv(age_data, "outputs/data/age_data.csv")

# sort and export neighbourhoods by general location
location_based_data <- cleaned_arrest_data |>
  mutate(
    area_category = case_when(
      crime_neighbourhood %in% c("Harbourfront-CityPlace (165)",
        "Kensington-Chinatown (78)",
        "Wellington Place (164)",
        "St Lawrence-East Bayfront-The Islands (166)",
        "West Queen West (162)",
        "Downtown Yonge East (168)",
        "University (79)", "Yonge-Bay Corridor (170)",
        "South Parkdale (85)", "Moss Park (73)",
        "Trinity-Bellwoods (81)", "The Beaches (63)",
        "North Riverdale (68)",
        "Palmerston-Little Italy (80)",
        "Fort York-Liberty Village (163)",
        "Annex (95)",
        "South Riverdale (70)", "Regent Park (72)",
        "High Park North (88)", "Yonge-Eglinton (100)",
        "High Park-Swansea (87)",
        "Cabbagetown-South St.James Town (71)",
        "Church-Wellesley (167)",
        "Bay-Cloverhill (169)",
        "Dovercourt Village (172)",
        "Rosedale-Moore Park (98)",
        "Wychwood (94)",
        "Runnymede-Bloor West Village (89)"
      ) ~ "downtown",
      crime_neighbourhood %in% c("Casa Loma (96)", "Mount Pleasant East (99)",
                                 "Yonge-St.Clair (97)",
                                 "Forest Hill South (101)",
                                 "Bedford Park-Nortown (39)",
                                 "Lawrence Park South (103)",
                                 "Bridle Path-Sunnybrook-York Mills (41)",
                                 "Forest Hill North (102)",
                                 "Lawrence Park North (105)") ~ "midtown",
      TRUE ~ "GTA"
    )
  )
write_csv(location_based_data, "outputs/data/location_based_data.csv")

# sort and export arrest count by general location
summarized_data <- location_based_data |>
  filter(arrest_year == 2019) |>
  group_by(area_category) |>
  summarise(arrest_count = sum(arrest_count, na.rm = TRUE))

write_csv(summarized_data, "outputs/data/summarized_data.csv")

# sort and export arrest count by general location and type of crime
crime_and_location <- location_based_data |>
  filter(arrest_year == 2019) |>
  group_by(crime_category, area_category) |>
  summarise(arrest_count = sum(arrest_count, na.rm = TRUE))

write_csv(crime_and_location, "outputs/data/crime_and_location.csv")

# Sort and export data of Age Cohort and Crime Category
crime_and_age <- cleaned_arrest_data |>
  filter(arrest_year == 2019) |>
  group_by(crime_category, age_cohort) |>
  summarise(arrest_count = sum(arrest_count, na.rm = TRUE))

write_csv(crime_and_age, "outputs/data/crime_and_age.csv")