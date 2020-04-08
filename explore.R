library(tidyverse)
fines <- read_csv("data/all_fines.csv")

# Repeat offenders
fines %>% count(org_fined, sort = TRUE) %>% 
  slice(1:10) %>% 
  mutate(org_fined = fct_reorder(org_fined, n)) %>% 
  ggplot(aes(org_fined, n)) +
  geom_col()+
  coord_flip()+
  labs(
    title = "Top 10 offenders",
    y = "Number of times fined",
    x = "",
    caption = "https://blog.rmhogervorst.nl"
  )
  
