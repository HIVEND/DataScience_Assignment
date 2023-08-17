library(tidyverse)
library(dplyr)
library(stringi)
library(scales)

# Set working directory
setwd("C:/Users/RISHU JHA/Desktop/DS Assignment/")


# Read CSV files for different years
house2019 = read_csv("Datasets/House Price-2019.csv", show_col_types = FALSE)
house2020 = read_csv("Datasets/House Price-2020.csv", show_col_types = FALSE)
house2021 = read_csv("Datasets/House Price-2021.csv", show_col_types = FALSE)
house2022 = read_csv("Datasets/House Price-2022.csv", show_col_types = FALSE)

# Rename columns for consistency
colnames(house2019) = c("ID", "Price", "Year", "PostCode", "PAON", "SAON", "FL", "House Num", "Flat", "Street Name",
                        "Locality", "Town", "District", "County", "Type1", "Type2")
colnames(house2020) = c("ID", "Price", "Year", "PostCode", "PAON", "SAON", "FL", "House Num", "Flat", "Street Name",
                        "Locality", "Town", "District", "County", "Type1", "Type2")
colnames(house2021) = c("ID", "Price", "Year", "PostCode", "PAON", "SAON", "FL", "House Num", "Flat", "Street Name",
                        "Locality", "Town", "District", "County", "Type1", "Type2")
colnames(house2022) = c("ID", "Price", "Year", "PostCode", "PAON", "SAON", "FL", "House Num", "Flat", "Street Name",
                        "Locality", "Town", "District", "County", "Type1", "Type2")

# Combine data from different years into a single tibble, removing NAs and duplicates
HousePrices = rbind(house2019, house2020, house2021, house2022) %>%
  na.omit() %>%
  distinct() %>%
  as_tibble()

# View the combined dataset
View(HousePrices)

# Write the combined dataset to a CSV file
write.csv(HousePrices, "cleanData/Combined_House_Pricing_2019-2022.csv")

# Filter the dataset based on selected counties
FilteredHousePrices = filter(HousePrices, County == 'OXFORDSHIRE' | County == 'YORK' | County == 'WEST YORKSHIRE' | County == 'NORTH YORKSHIRE' | County == 'SOUTH YORKSHIRE')

# Replace "YORK" with "YORKSHIRE" in the COUNTY column
FilteredHousePrices$County[FilteredHousePrices$County == "YORK"] <- "YORKSHIRE"
# View the filtered dataset
view(FilteredHousePrices)
# Define a pattern to extract the short postcode
pattern = ' .*$'
# Manipulate and clean the filtered dataset
FilteredHousePrices = FilteredHousePrices %>%
  mutate(shortPostcode = gsub(pattern, "", PostCode)) %>%
  mutate(Year = str_trim(substring(Year, 1, 4))) %>%
  select(PostCode, shortPostcode, Year, PAON, Price) %>%
  na.omit() %>%
  distinct() %>%
  as_tibble()

# View the cleaned and manipulated dataset
View(FilteredHousePrices)

# Write the cleaned and manipulated dataset to a CSV file
write.csv(FilteredHousePrices, "cleanData/Cleaned_House_Pricing_2019-2022.csv", row.names = FALSE)
