data/data_clean.rds: code/01_data_cleaning.R data/covid_sub.csv
	Rscript code/01_data_cleaning.R
	
.PHONY: make_tables
make_tables: output/tables_diabetes_died.rds output/table_eda.rds output/table_pneumonia_died.rds output/table_sex_died.rds
	
output/tables_diabetes_died.rds: data/data_clean.rds
	Rscript code/02_making_tables.R
	
output/table_eda.rds: data/data_clean.rds
	Rscript code/02_making_tables.R

output/table_pneumonia_died.rds: data/data_clean.rds
	Rscript code/02_making_tables.R

output/table_sex_died.rds: data/data_clean.rds
	Rscript code/02_making_tables.R
	
.PHONY: make_plots
make_plots: output/Medical_History_home.png output/Medical_History_hospitalized.png output/Respiratory_Health_home.png output/Respiratory_Health_hospitalized.png
	Rscript code/03_making_plots.R
	
output/Medical_History_home.png: data/data_clean.rds
	Rscript code/03_making_plots.R
	
output/Medical_History_hospitalized.png: data/data_clean.rds
	Rscript code/03_making_plots.R
	
output/Respiratory_Health_home.png: data/data_clean.rds
	Rscript code/03_making_plots.R
	
output/Respiratory_Health_hospitalized.png: data/data_clean.rds
	Rscript code/03_making_plots.R
	
	
.PHONY: make_models
make_models: output/both_models.rds output/both_regression_tables.rds
	Rscript code/04_making_models.R
	
output/both_models.rds: data/data_clean.rds
	Rscript code/04_making_models.R
	
output/both_regression_tables.rds: data/data_clean.rds
	Rscript code/04_making_models.R

.PHONY: install
install:
	Rscript -e "renv::restore(prompt=FALSE)"
	
.PHONY: clean
clean:
	rm -f data/*.rds output/*.rds output/*.png