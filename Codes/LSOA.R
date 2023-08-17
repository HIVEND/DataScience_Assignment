library(data.table)
library(tidyverse)
library(dplyr)

setwd("C:/Users/RISHU JHA/Desktop/DS Assignment/")

Cleaned_HP <- read.csv("cleanData/Cleaned_Town_population.csv")

LSOA <- fread("Datasets/Postcode to LSOA.csv")
pattern <- ' .*$'
LSOA_Cleaned <- LSOA %>%
  select(lsoa11cd, pcds) %>% 
  mutate(shortPostcode = gsub(pattern, "", pcds)) %>% 
  right_join(Cleaned_HP, by = "shortPostcode")  %>% 
  group_by(lsoa11cd) %>% 
  select(lsoa11cd, shortPostcode, Town, District, County) 

colnames(LSOA_Cleaned)[1] <- "LSOA code"

View(LSOA_Cleaned)
write.csv(LSOA_Cleaned, "cleanData/Cleaned_LSOA.csv", row.names = FALSE, col.names = FALSE)
