library(readr)
library(dplyr)

read_csv("data/all_fines_raw.csv") %>% 
  # date is not in lovely ISO 8601 but American date format.
  mutate(date = as.Date.character(date, format = "%m/%d/%Y")) %>% 
  # make the names of the columns like the website
  rename(country = name, org_fined = controller) %>% 
  write_csv("data/all_fines.csv")

  