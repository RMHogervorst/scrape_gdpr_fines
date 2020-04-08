## No rvest, just pure text


library(stringr)
library(readr)
### or, hack it together
page_raw <- readr::read_file(file = link)
start = stringr::str_locate(page_raw, "var allItemsPriceGrouped =")[2]
end = stringr::str_locate(page_raw, "\r\n</script>\r\n<!-- footer -->")[1]
substring <- stringi::stri_sub(page_raw, from = start+1, to = end[1]-2)
result <- jsonlite::fromJSON(substring)

start2 <- stringr::str_locate(page_raw, "var items = ")[2]
end2 <- stringr::str_locate(page_raw, "var allItemsPriceGrouped =")[1]
substring2 <- stringi::stri_sub(page_raw, from = start+1, to = end[1]-2)
result2 <- jsonlite::fromJSON(substring2,simplifyDataFrame = TRUE)
all <- tibble(id = 1:250)
missing1 <- anti_join(all, result)
missing2 <- anti_join(all, result2)
readr::write_file(substring, "temp.txt")
readr::write_file(substring2, "temp2.txt")
