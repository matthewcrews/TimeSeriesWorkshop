library(data.table)
library(dplyr)
library(tidyr)
library(stringr)

RawStockData <- fread("Dated_stocks-us-adjClose.csv", fill=T)
RawStockData
StockData <- gather(RawStockData, key=Ticker, value=Close, names(RawStockData)[-1]) %>%
  filter(!is.na(Close))

names(StockData) <- c('ObsDate', 'Ticker', 'ClosePrice')
head(StockData)

TickerSummary <- StockData %>% 
  group_by(Ticker) %>% 
  summarise(min(ClosePrice), max(ClosePrice)) %>%
  filter(!is.na(`min(ClosePrice)`)) %>%
  mutate(`range(ClosePrice)` = `max(ClosePrice)` - `min(ClosePrice)`)


head(StockData)
summary(StockData)

MonthlySummary <- StockData %>%
  mutate(Month = str_sub(ObsDate, 1, 7))

head(MonthlySummary)




