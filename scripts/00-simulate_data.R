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

set.seed(123)

# simulating data for Arrest Count by Ward
num_wards <- 25
low_arrest_count <- 5000
high_arrest_count <- 65000

sim_arrest_data <-
  tibble(
    sim_arrest_count =
    runif(n = num_wards, min = low_arrest_count, max = high_arrest_count),
    noise = rnorm(n = num_wards, mean = 0, sd = 3)
  ) |>
  select(-noise)

print(sim_arrest_data, n = 25)


# simulating data for Average Household income by Ward
num_wards <- 25
low_hh_income <- 5000
high_hh_income <- 65000

sim_hh_data <-
  tibble(
    sim_hh_income =
    runif(n = num_wards, min = low_hh_income, max = high_hh_income),
    noise = rnorm(n = num_wards, mean = 0, sd = 3)
  ) |>
  select(-noise)

print(sim_hh_data, n = 25)
