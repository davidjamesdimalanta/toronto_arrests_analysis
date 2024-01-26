#### Preamble ####
# Purpose: Clean the 2023 Toronto Arrest Countes data set &
# the Toronto Census Data from OpenDataToronto
# Author: David James Dimalanta
# Date: January 26 2024
# Contact: David James Dimalanta
# License: MIT
# Pre-requisites: 01-download_data.R

#install necesarry packages to reproduce paper
library(janitor)
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
    ward = case_when(
      str_detect(crime_neighbourhood,
                 "\\(1|2|3|4|5|6)\\") ~ "1",
      str_detect(crime_neighbourhood,
                 "\\(15|28|29|30|110|111|112|113|115|160\\)") ~ "5",
      str_detect(crime_neighbourhood,
                 "\\(21|22|23|24|25|154\\)") ~ "7",
      str_detect(crime_neighbourhood,
                 "\\(72|73|167|168\\)") ~ "13",
      str_detect(crime_neighbourhood,
                 "\\(42|43|44|45|149|150\\)") ~ "16",
      str_detect(crime_neighbourhood,
                 "\\(36|37|38|50|151|152|153\\)") ~ "18",
      str_detect(crime_neighbourhood,
                 "\\(78|120|121|122|123|124|139|164\\)") ~ "20",
      str_detect(crime_neighbourhood,
                 "\\(119|125|126|127|137|156|157|142\\)") ~ "21",
      str_detect(crime_neighbourhood,
                 "\\(116|117|118|128|129\\)") ~ "22",
      str_detect(crime_neighbourhood,
                 "\\(140|141|135\\)") ~ "24",
      str_detect(crime_neighbourhood,
                 "\\((7|8|9|10|11|12|13|159)\\)") ~ "2",
      str_detect(crime_neighbourhood,
                 "\\((14|15|16|17|18|19|20)\\)") ~ "3",
      str_detect(crime_neighbourhood,
                 "\\((83|84|85|86|87|88|89|90|95|114)\\)") ~ "4",
      str_detect(crime_neighbourhood,
                 "\\((155|26|27|33|34|35)\\)") ~ "6",
      str_detect(crime_neighbourhood,
                 "\\((31|32|39|100|102|103|105|108)\\") ~ "8",
      str_detect(crime_neighbourhood,
                 "\\((91|92|93|109|172)\\)") ~ "9",
      str_detect(crime_neighbourhood,
                 "\\((162|163|165|166|169|170)\\)") ~ "10",
      str_detect(crime_neighbourhood,
                 "\\((79|80|81|71|74|75)\\)") ~ "11",
      str_detect(crime_neighbourhood,
                 "\\((94|96|97|98|99|101|104|107)\\)") ~ "12",
      str_detect(crime_neighbourhood,
                 "\\((57|58|59|65|66|67|68|69|70)\\)") ~ "14",
      str_detect(crime_neighbourhood,
                 "\\((41|55|56)\\)") ~ "15",
      str_detect(crime_neighbourhood,
                 "\\((46|47|48|49|52|53)\\)") ~ "17",
      str_detect(crime_neighbourhood,
                 "\\((54|60|61|62|63|64)\\)") ~ "19",
      str_detect(crime_neighbourhood,
                 "\\(130)\\") ~ "23",
      str_detect(crime_neighbourhood,
                 "\\((131|133|134|136|143)\\)") ~ "25",
      TRUE ~ "GTA"
    ),
  )

write_csv(location_based_data, "outputs/data/location_based_data.csv")

# sort and export arrest count by ward
summarized_data <- location_based_data |>
  filter(ward != "GTA") |>
  group_by(ward) |>
  summarise(arrest_count = sum(arrest_count, na.rm = TRUE))

write_csv(summarized_data, "outputs/data/summarized_data.csv")



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

# filter census data to only show ward #, average, and median HH income
filtered_census_data <- cleaned_census_data |>
  select(ward, avg_income, med_income)

head(filtered_census_data)
write_csv(filtered_census_data, "outputs/data/filtered_census_data.csv")