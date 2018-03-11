library(data.table)
library(dplyr)
library(tidyr)

raw_stock_data <- fread("Dated_stocks-us-adjClose.csv", fill=T)
stock_data <- gather(raw_stock_data, key=Ticker, value=Close, names(raw_stock_data)[-1])
head(stock_data)

ticker_summary <- stock_data %>% 
  group_by(Ticker) %>% 
  summarise(min(Close), max(Close)) %>%
  filter(!is.na(`min(Close)`)) %>%
  mutate(`range(Close)` = `max(Close)` - `min(Close)`)

