# Socio-Economic Disparities and Law Enforcement in Toronto: An Analysis of Arrest Trends and Median Household Income Across City Wards
## Overview
The project explores the intricate relationship between socio-economic status and law enforcement activities within the diverse urban landscape of Toronto. The primary focus is on examining arrest count data and median household income across the city's wards, aiming to uncover patterns and disparities.
## File Structure
The repo is structured as:

- `inputs/data` contains the data sources used in analysis including the raw data.
- `outputs/data` contains the cleaned dataset that was constructed.
- `outputs/paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
- `scripts` contains the R scripts used to simulate, download and clean data.

## How to reproduce this paper
1. Click the Green `Code` button above and copy the `HTTPS` or copy this: `https://github.com/davidjamesdimalanta/toronto_arrests_analysis.git`
2. in the terminal of your project directory, run `git clone https://github.com/davidjamesdimalanta/toronto_arrests_analysis.git`
3. Navigate to `scripts/01-download_data.R` and run the R script
4. Navigate to `scripts/02-data_cleaning.R` and run the R script
5. Navigate to `scripts/03-test_data.R` and run the R script 
6. Navigate to `scripts/00-simulate_data.R` and run the R script
7. Navigate to `outputs/paper/paper.qmd` and render the quarto file

## LLM usage
I acknowledge that I used LLMs to help write this paper. In order to view the usage, navigate to `inputs/llm/usage.txt`.