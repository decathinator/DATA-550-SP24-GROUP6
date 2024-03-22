# Situate yourself
here::i_am("code/04_making_models.R")

# Read in clean data
data <- readRDS(
  file = here::here("data/data_clean.rds")
)

# Load Libraries
library(gtsummary)
library(tidyverse)
library(labelled)

# Subset Data to only include patients that are hospitalized
# Coerce variables as factors
data_hosp <- data %>% filter(patient_type=="hospitalization") %>%
  mutate(
    sex = as.factor(sex),
    pregnant = as.factor(pregnant),
    obesity = as.factor(obesity),
    diabetes = as.factor(diabetes),
    copd = as.factor(copd),
    inmsupr = as.factor(inmsupr),
    hipertension = as.factor(hipertension),
    cardiovascular = as.factor(cardiovascular),
    renal_chronic = as.factor(renal_chronic),
    other_disease = as.factor(other_disease),
    pneumonia = as.factor(pneumonia),
    tobacco = as.factor(tobacco),
    asthma = as.factor(asthma),
    intubed = as.factor(intubed),
    icu = as.factor(icu)
  )

# Add labels back to data
var_label(data_hosp) <- list(
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

# Create a model based on patient respiratory health for patients hospitalized
respiratory_model_hosp <- glm(classification_new ~ pneumonia + tobacco + asthma + copd + intubed, 
                              family = "binomial", data = data_hosp)

# Create a model based on patient medical history and demographics
patient_hx_model_hosp <- glm(classification_new ~ sex + age + obesity + diabetes + inmsupr + renal_chronic + other_disease +
                               hipertension + cardiovascular, 
                             family = "binomial", data = data_hosp)

# Put Patient Respiratory Health Model in a Table
respiratory_regression_table <- 
  tbl_regression(respiratory_model_hosp) |>
  add_global_p() |>
  bold_labels()

# Put Patient Medical History Model in a Table
patient_hx_regression_table <- 
  tbl_regression(patient_hx_model_hosp) |>
  add_global_p() |>
  bold_labels()


# Put both models objects in a list
both_models <- list(
  First = respiratory_model_hosp,
  Second = patient_hx_model_hosp
)

# Save the model list to output folder
saveRDS(
  both_models,
  file = here::here("output/both_models.rds")
)

# Put both regression table objects in a list
both_regression_tables <- list(
  First = respiratory_regression_table,
  Second = patient_hx_regression_table
)

# Save the regression table list to output folder
saveRDS(
  both_regression_tables,
  file = here::here("output/both_regression_tables.rds")
)
