
#title: "R project crypto/stock return data, calculating return & uncorrelated clusters"
#output: r studio
# packages that will be used{r}
install.packages("tidyverse")
install.packages("crypto2")
install.packages("lubridate")
install.packages("rvest")
install.packages("stats")
install.packages("stats")
install.packages("magrittr")
install.packages("quantmod")
install.packages("tidyquant")
install.packages("dendextend")
install.packages("portfolioanalytics")

library(tidygraph)# graph data structures
library(tidyquant)# quantitatives finance functionalities tidyverse framework.
library(tidyr)#reshaping data frames.
library(tidyselect)# selecting columns or varibles.
library(tidytext)# text mining and natural language processing.
library(tidyverse)#(ggplot2,dplyr,tidyr)  
library(crypto2)# historical price , data, returns.
library(lubridate)# date and time data.parsing,manuplating and formatting dates,times
library(rvest)#(web scraping in r)
library(stats)# basic statistical calculation, hypothesis, testing, regression modeles
library(stats4)
library(magrittr)# operator %>% data manupulation and analysis functions.
library(quantmod)# time series , downloading financial data, fitting models and performing backtest.
library(dendextend)# hierachical clustring objects and additional func like vis, manu and comparing.
library(PortfolioAnalytics)# risk managment,risk metrics and portfolio performance.
#section 1 - get a list of all crypto ticket, and their price history.
crypto_list()
crypto_currency <- crypto_history(limit = 1)
crypto_currency %>% 
mutate(timestamp=as.Date(as.character(timestamp))) %>% ggplot()+geom_line(aes(timestamp,close))
top_100_by_marketcap <- crypto_list() %>% slice(1:100)
view(top_100_by_marketcap)
top_100_prices <- crypto_history(top_100_by_marketcap)
view(top_100_prices)
top_100_crypto_prices<-crypto_history(top_100_by_marketcap) %>% mutate(timestamp = as.Date(as.character(timestamp)))
view(top_100_crypto_prices)
#-calculate cryptocurrency returns 
crypto_daily_returns <- top_100_crypto_prices %>% arrange(symbol, timestamp)%>% mutate(dailyReturn = close/lag(close, 1)-1) %>% select(timestamp, name, symbol,dailyReturn)
view(crypto_daily_returns)
# working with hierarchical clustering algorithm

hc <-
  crypto_daily_returns %>%
  pivot_wider(id_cols = timestamp, names_from = name, values_from = dailyReturn) %>%
  select(timestamp) %>%
  cor(use = "complete.obs") %>%
  abs() %>%
  dist() %>%
  hclust()

hc %>%
  as.dendrogram() %>%
  plot()


number_clusters <- 4

hc %>%
as.dendrogram() %>%
color_branches(k = number_clusters) %>%
color_labels(k = number_clusters) %>%
set("labels_cex", 0.3) %>%
as.ggdend() %>%
ggplot() +
labs(title = "Dendrogram of the top 100 Cryptocurrencies by market cap")
cutree(hc, k = number_clusters) %>%
  as.data.frame() %>%
  rename(cluster = 1) %>%
  mutate(token_name = row.names(.)) %>%
  filter(cluster == 4) #Stable coins
# get all price history for s&p500 companies
tidyquant::tq_get("AAPL") %>%
  ggplot() +
  geom_line(aes(date, adjusted))
stock_table_url <- "https://en.wikipedia.org/wiki/List_of_S%26P_500_companies"
view(stock_table_url)



  
  
