library(rvest)
library(stringr)
link<- "https://www.privacyaffairs.com/gdpr-fines/"
# some due dilligence. the robots.txt of this website allows all.
# looking at the page source, It should be relatively simple to retrieve the data, it is
# in the javascript session (see picture)
page <- read_html(link)


temp <- page %>% html_nodes("script") %>% .[9] %>% 
  rvest::html_text() 

ends <- str_locate_all(temp, "\\]")
starts <- str_locate_all(temp, "\\[")
table1 <- temp %>% stringi::stri_sub(from = starts[[1]][1,2], to = ends[[1]][1,1]) %>% 
  str_remove_all("\n") %>% 
  str_remove_all("\r") %>%
  jsonlite::fromJSON()

##### I don't actually know what this is.
# table2 <- temp %>% stringi::stri_sub(from = starts[[1]][2,2], to = ends[[1]][2,1]) %>% 
#   str_remove_all("\n") %>% 
#   str_remove_all("\r") %>%  
#   jsonlite::fromJSON()

readr::write_csv(table1, "data/all_fines_raw.csv")

