#### Preamble ####
# Purpose: Test the cleaned 2023 Toronto Arrest Countes &
# the Toronto Census Data data sets from OpenDataToronto
# Author: David James Dimalanta
# Date: January 26 2024
# Contact: David James Dimalanta
# License: MIT
# Pre-requisites: 01-data_cleaning.R

# Verifying Column Names and Types using "testthat" package
expected_cols <- c("age_cohort", "age_group")
expect_true(all(
                expected_cols
                %in% names(cleaned_arrest_data)), "Column names don't match.")

# Checking data types // if there is an error,
# the error message will display in the terminal
expect_true(is.character(cleaned_arrest_data$age_cohort),
            "age_cohort is not a character column.")
expect_true(is.character(cleaned_arrest_data$crime_neighbourhood),
            "crime_neighbourhood is not a character column.")
expect_true(is.character(cleaned_arrest_data$sex),
            "sex is not a character column.")
expect_true(is.double()(cleaned_arrest_data$x_id),
            "id is not an double")
expect_true(is.double()(cleaned_arrest_data$arrest_year),
            "arrest_year is not an double")

# Checking for Missing Values
expect_true(all(complete.cases(cleaned_arrest_data)),
            "missing values in the data.")