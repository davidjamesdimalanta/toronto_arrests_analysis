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

# plot arrest count by general location
ggplot(summarized_data,
       aes(x = factor(ward, levels = c(
         "Ward 1", "Ward 5", "Ward 7",
         "Ward 13", "Ward 16", "Ward 18",
         "Ward 20", "Ward 21", "Ward 22",
         "Ward 24", "Ward 2", "Ward 3", "Ward 4",
         "Ward 6", "Ward 8", "Ward 9", "Ward 10",
         "Ward 11", "Ward 12", "Ward 14",
         "Ward 15", "Ward 17", "Ward 19",
         "Ward 23", "Ward 25",
         "Outer Toronto Ward"
       )), y = arrest_count)) +
  geom_bar(stat = "identity") +
  labs(title = "Toronto Arrest Count by General Location",
       x = "Neighbourhood", y = "Arrest Count")
theme(axis.text.x = element_text(size = 8, angle = 45, hjust = 1))

# plot census data
census_data <- read_csv("outputs/data/census_data.csv")
ward_hh_income <- census_data |>
  slice(1:26)
kable(census_data, format = "pipe", caption = "Toronto Census Data by Ward")
