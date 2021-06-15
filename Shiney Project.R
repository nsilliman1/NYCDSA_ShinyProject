
library(quantmod)
library(tidyverse)
library(tidyquant)
library(BatchGetSymbols)

# company_list = read_csv(file = "s-and-p-500-companies/data/constituents.csv")
#choose 2 major US stock exchanges

company_list = rbind(tq_exchang e("NASDAQ"), tq_exchange("NYSE"))
# add in exchange label?
#filter out companies with 0 market cap
# https://www.statista.com/statistics/270126/largest-stock-exchange-operators-by-market-capitalization-of-listed-companies/#:~:text=The%20New%20York%20Stock%20Exchange,dollars%20as%20of%20February%202021.
company_list1 = company_list %>% mutate(market.cap.Billions = market.cap/1000000000) %>% 
  filter(market.cap.Billions>0, country == 'United States')

# compare to what I see in the link above
company_list1 %>% summarise(n = COUNT_UNIQUE(symbol), TotalMarCap = sum(market.cap.Billions))


temp = company_list1$symbol[1:4000]

DataPull = BatchGetSymbols(temp, first.date = '2021-01-01', last.date = "2021-06-01")

# set threshold at 1B? add in bitcoin?
df = DataPull[[2]]

#count unique - why were some of them dropped
COUNT_UNIQUE(df$ticker)

df = inner_join(df, company_list, by = c('ticker' = 'symbol'))
df = df %>% mutate()

df %>% filter(Name == "3M Company") %>% ggplot(aes(x = ref.date, y = price.close)) + geom_line()

ggplot(company_list1, aes(x = market.cap.Billions)) + geom_histogram(binwidth = 3) + coord_cartesian(xlim = c(1,10))


# decide on thereshold for analysis - I dont think I am going to cut anymore
ggplot(company_list1, aes(x = market.cap.Billions)) + geom_histogram(binwidth = .1) + coord_cartesian(xlim = c(0,1))