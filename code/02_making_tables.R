here::i_am(
  #! TO DO: add appropriate location
  "code/02_making_tables.R"
)

library(dplyr)
library(psych)

data <- readRDS(
  file = here::here("data/data_clean.rds")
)


# Summary statistics for each variable
describe(data)

eda <- describe(data)

saveRDS(
  eda,
  file = 
    here::here("output/table_eda.rds")
)


# 2*2 table for sex and dead
data$died <- factor(data$died, levels = c(0, 1), labels = c("Not Dead", "Dead"))
table_sex_died <- table(data$sex, data$died)
print(table_sex_died)
table_sex_died <- addmargins(table_sex_died)

saveRDS(
  table_sex_died,
  file = 
    here::here("output/table_sex_died.rds")
)

# Relationship between pneumonia and mortality
table_pneumonia_died <- table(data$pneumonia, data$died)

saveRDS(
  table_pneumonia_died,
  file = 
    here::here("output/table_pneumonia_died.rds")
)

# Relationship between diabetes and mortality
table_diabetes_died <- table(data$diabetes, data$died)

saveRDS(
  table_diabetes_died,
  file = 
    here::here("output/table_diabetes_died.rds")
)
