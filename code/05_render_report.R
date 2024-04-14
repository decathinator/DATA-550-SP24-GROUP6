library(here)
here::i_am("code/05_render_report.R")

library(rmarkdown)

WHICH_CONFIG <- Sys.getenv("WHICH_CONFIG")
print(WHICH_CONFIG)
config_list <- config::get(
  config= WHICH_CONFIG
)

report_filename <- paste0(
  "Final_Report_config_", WHICH_CONFIG, ".html"
)

render(here('Final_Report.Rmd'),
       params = list(production = TRUE),
       output_file = report_filename 
)