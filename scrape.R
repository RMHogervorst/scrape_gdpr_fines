library(rvest)
library(V8)
ctx <- v8()
link<- "https://www.privacyaffairs.com/gdpr-fines/"
# some due dilligence. the robots.txt of this website allows all.
# looking at the page source, It should be relatively simple to retrieve the data, it is
page <- read_html(link)


page %>% html_nodes(xpath = "(.//script)[9]") %>% 
  html_text() %>% 
  ctx$eval()

table1 <- ctx$get("items")

readr::write_csv(table1, "data/all_fines_raw.csv")

