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

# Get ARRESTS COUNTS package
package <- show_package(
  "police-annual-statistical-report-arrested-and-charged-persons"
)
package

# Get all resources for this package
resources <- list_package_resources(
  "police-annual-statistical-report-arrested-and-charged-persons"
)

# Identify datastore resources; by default, Toronto Open Data sets
# datastore resource format to CSV for non-geospatial and GeoJSON
# for geospatial resources
datastore_resources <- filter(resources,
                              tolower(format) %in% c("csv", "geojson"))

# Load the first datastore resource as a sample
raw_arrest_data <-
  filter(datastore_resources, row_number() == 1) |>
  get_resource()

raw_arrest_data

# Generating the Data into a CSV file in 'inputs/data'
write.csv(raw_arrest_data, file = "inputs/data/raw_arrest_data.csv",
          sep = ",",
          row.names = FALSE)


## Leveraged Code From Thomas Fox
# https://github.com/ThomasWilliamFox/toronto_child_care
# Download Ward Profiles (25-Ward Model) data set from opndatatoronto

package_ward_profiles <-
  list_package_resources("6678e1a6-d25f-4dff-b2b7-aa8f042bc2eb")
package_ward_profiles

# Census data including population and average household income
census_data <- get_resource("16a31e1d-b4d9-4cf0-b5b3-2e3937cb4121")
raw_census_data <- census_data[[1]]

# Ward names and corresponding numbers data
raw_ward_names <- get_resource("ea4cc466-bd4d-40c6-a616-7abfa9d7398f")


#### Save data ####

# Write raw census data to data inputs folder
write_csv(raw_census_data, "inputs/data/raw_census_data.csv")

# Write raw ward names and numbers to data inputs folder
write_csv(raw_ward_names, "inputs/data/raw_ward_names.csv")