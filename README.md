# Code Description

`code/01_data_cleaning.R`
- reads `data/covid_sub.csv`
- dichotomizes `classification` variable on whether patient has covid (value 1-3) or not (value 4+)
- makes a new variable for Death that is dichotomized: 0 for no death and 1 for death (date is present)
- adds labels for all variables
- creates `data/data_clean.rds`

`code/02_making_tables.R`
- reads `data/data_clean.rds`
- creates tables `output/tables_diabetes_died.rds`, `output/table_eda.rds`, `output/table_pneumonia_died.rds`, `output/table_sex_died.rds`

`code/03_making_plots.R`
- reads `data/data_clean.rds`
- creates plots `output/Medical_History_home.png`, `output/Medical_History_hospitalized.png`, `output/Respiratory_Health_home.png`, `output/Respiratory_Health_hospitalized.png`

`code/04_making_models.R`
- reads `data/data_clean.rds`
- creates a model based on patient respiratory health for patients hospitalized
- creates a model based on patient medical history and demographics
- creates `output/both_models.rds` and `output/both_regression_tables.rds`

`code/05_render_report.R`
- renders `Final_Report.Rmd`


## Description of Makefile
- include rule to make final report based on config status `Final_Report_config_${WHICH_CONFIG}.html`. To make the file, simply first set WHICH_CONFIG in the system environment and then `make Final_Report_config_${WHICH_CONFIG}.html`
- include rule to make `data/data_clean.rds`
- include rule `make_tables` to make the following tables: `output/tables_diabetes_died.rds` `output/table_eda.rds` `output/table_pneumonia_died.rds`` output/table_sex_died.rds`
- include rule `make_plots ` to make the following plots: `output/Medical_History_home.png` `output/Medical_History_hospitalized.png` `output/Respiratory_Health_home.png` `output/Respiratory_Health_hospitalized.png`
- include rule `make_models` to run regression models and create the following output: `both_models.rds` `both_regression_tables.rds`
- include rule to make install - which runs a Rscript that synchronizes user's R packages 
  to the versions used in the project
- include rule to clean 

## Renv Lock File
- Contains the versions of the R packages used in project
  
## renv/
- contains activate.R script (part of the process of making everything automatic-
  sourced in from the Rprofile for us to automatically start using project specific library)
- contains settings.dcf
  
## To Synchronize Package Repository
- Open make file & "make" the .PHONY rule install to synchronize R packages

