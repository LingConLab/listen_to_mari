setwd("/home/agricolamz/work/articles/2023_DiaL2/2023_mari/")
library(tidyverse)
df <- readxl::read_xlsx("mari_loc.xlsx")

df %>% 
  rename(source = X5,
         time_start = X3,
         time_end = X4,
         sentence = X7) %>% 
  filter(preposition %in% c("в_drop", "в")) %>% 
  mutate(audio = str_remove(source, ".eaf"),
         audio = str_c(audio, "-", round(time_start*1000)),
         audio = str_c(audio, "-", round(time_end*1000)),
         audio = str_c("http://lingconlab.ru/MariRus/OUT/", audio, ".wav")) %>% 
  select(sentence, audio, preposition) %>% 
  mutate(id = 1:n()) %>%
  select(id, sentence, audio, preposition) %>% 
  sample_n(nrow(.)) %>% 
  write_csv("result.csv")

df %>% 
  select(id, sentence) %>% 
  mutate(preposition = "") %>% 
  writexl::write_xlsx("fill_me.xlsx")
