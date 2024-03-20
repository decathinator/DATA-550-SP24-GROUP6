here::i_am("code/01_data_cleaning.R")
absolute_path_to_data <- here::here("data/covid_sub.csv")
data <- read.csv(absolute_path_to_data, header = TRUE)

library(pacman)
p_load(tidyverse, janitor, labelled)

#Clean the variable names
data <- janitor::clean_names(data)

colnames(data)[1] <- "id"


# Dichotomize `classification` variable on whether patient has covid (value 1-3) or not (value 4+)
data <- data %>% 
  mutate(classification_new = case_when(
    is.na(clasiffication_final) ~ NA,
    clasiffication_final >= 1 & 
      clasiffication_final <= 3 ~ 1,
    clasiffication_final >= 4 ~ 0))


# Make a new variable for Death that is dichotomized: 0 for no death and 1 for death (date is present)
data <- data %>% 
  mutate(died = case_when(
    is.na(date_died) ~ 0,
    TRUE ~ 1
  ))


# Add labels to all the variables
var_label(data) <- list(
  id = "ID",
  usmer = "Medical Unit of Levels 1, 2, or 3",
  medical_unit = "Medical Unit",
  sex = "Sex",
  patient_type = "Type of Care Received",
  date_died = " Date of Death",
  intubed = "Connected to Ventilator",
  pneumonia = "Pneumonia",
  age = "Age (Years)",
  pregnant = "Pregnant",
  diabetes = "Diabetes",
  copd = "COPD",
  asthma = "Asthma",
  inmsupr = "Immunosuppressed",
  hipertension = "Hypertension",
  other_disease = "Other Disease",
  cardiovascular = "Cardiovascular Disease",
  obesity = "Obesity",
  renal_chronic = "Chronic Renal Disease",
  tobacco = "Tobacco User",
  classification_new = "COVID Diagnosis",
  icu = "Admitted to ICU",
  clasiffication_final = "COVID Test Findings",
  died = "Died"
)


#Save the clean data
saveRDS(
  data, 
  file = here::here("data/data_clean.rds")
)
