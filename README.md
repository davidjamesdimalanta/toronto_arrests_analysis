# Socio-Economic Disparities and Law Enforcement in Toronto: An Analysis of Arrest Trends and Median Household Income Across City Wards
## Abstract
This paper investigates the correlation between socio-economic status and law enforcement activities in Toronto by analyzing arrest count data and median household income across the city's wards. Utilizing data from the Toronto Police Service and the 2021 Toronto Census, the research reveals significant disparities in arrest counts between wards categorized as 'low-income household neighbourhoods' and 'high-income household neighbourhoods.' Notably, it was found that some low-income areas, such as Ward 20 (Scarborough-Agincourt), experience higher arrest counts, while certain high-income wards like Ward 10 (Spadina-Fort York) also report substantial arrest figures, illustrating that socio-economic status is not a singular predictor of law enforcement activity. The findings of this study are crucial for urban policymakers and planners, as they underscore the complex interplay between socio-economic factors and crime within urban settings, highlighting the need for nuanced approaches to law enforcement and social policy in diverse urban communities. 
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