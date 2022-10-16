# Define the following 'special' locations:
# 'home' (i.e. Run.R and R/ folder)
# 'results' (i.e. A folder with today's date will be created here)

# Define any other locations you want:
# 'raw' (i.e. raw data)

# Initialize the project
org::initialize_project(
  env = .GlobalEnv,
  home = here::here("~/pj", "2022", "dbd-ahrq"),
  results = here::here("~/dropbox", "analytics", "2022", "dbd_ahrq"),
  raw = here::here("~/data", "2022", "dbd_ahrq"),
  clean = here::here("~/data", "2022", "dbd_ahrq"),
  paper = here::here("~/pj", "2022", "dbd-ahrq")
)

# do some analyses here

# It is a good practice to describe how the archived
# results are changing from day-to-day.
#
# We recommend saving this information as a text file
# stored in the `org::project$results` folder.
txt <- glue::glue("
  2019-01-01:
    Included:
    - Table 1
    - Table 2
  
  2019-02-02:
    Changed Table 1 from mean -> median
  
", .trim = FALSE)

org::write_text(
  txt = txt,
  file = fs::path(org::project$results, "info.txt")
)

library(data.table)
library(ggplot2)
library(tidytable)

# This function would access data located in org::project$raw
d <- clean_data("neuropsych.csv")

# These functions would save results to org::project$results_today
table_1(d)
figure_1(d)
figure_2(d)

# render the paper

rmarkdown::render(
  input = fs::path(org::project$paper, "index.Rmd"),
  output_dir = org::project$results,
  quiet = F
)
