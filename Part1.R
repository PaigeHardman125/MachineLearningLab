setwd("C:/Users/Paige Hardman/Desktop/NYCDSA/Machine_Learning_Lab")

knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)
# Your code here
library(ggplot2)
library(dplyr)
orders <- read.csv("data/Orders.csv", header = T, stringsAsFactors = F)
# Your code here
orders <- as.data.frame(orders)
head(orders)
sample(orders)

number.cleaner <- function(x){
word <- unlist(strsplit(x, split='$', fixed=TRUE))
word <- paste0(word[1], word[2])
word <- as.numeric(gsub(",", "", word)) # can also use gsub for the $ sign
}
orders$Sales <- sapply(orders$Sales, number.cleaner)
orders$Profit <- sapply(orders$Profit, number.cleaner)
# Another method:
# orders$New_sales = as.numeric(gsub('\\$|,', '', orders$Sales))
# orders$New_profit = as.numeric(gsub('\\$|,', '', orders$Profit))
# Your code here
library(lubridate)
orders$Order.Date <- as.Date(orders$Order.Date,"%m/%d/%y")
orders$Order.Month <- month(orders$Order.Date)

daily <- orders %>%
  group_by(Order.Date) %>%
  summarise( daily_sales=sum(Sales))
ggplot(daily, aes(Order.Date, daily_sales)) +
  geom_line() +
  xlab("Time") +
  ylab("Daily Orders Sales") +
  theme_bw() +
  geom_smooth()

# Your code here
orders$Order.Date <- as.Date(orders$Order.Date,"%m/%d/%y")
orders$Order.Month <- month(orders$Order.Date)

daily <- orders %>%
  group_by(Order.Date) %>%
  summarise( daily_quantity=sum(Quantity))
ggplot(daily, aes(Order.Date, daily_quantity)) +
  geom_line() +
  xlab("Time") +
  ylab("Daily Orders Sales") +
  theme_bw() +
  geom_smooth()

# Your code here
library(lubridate)
orders$Order.Date <- as.Date(orders$Order.Date,"%m/%d/%y")
orders$Order.Month <- month(orders$Order.Date)
daily <- orders %>%
  group_by(Order.Date) %>%
  summarise( daily_quantity=sum(Quantity))
ggplot(daily, aes(Order.Date, daily_quantity)) +
  geom_line() +
  xlab("Time") +
  ylab("Daily Orders Sales") +
  theme_bw() +
  geom_smooth()

monthly <- orders %>%
  group_by(Order.Month) %>%
  summarise(monthly_quantity=sum(Quantity))
ggplot(monthly, aes(Order.Month, monthly_quantity, group=1)) +
  geom_line(color="Blue") +
  xlab("Month") +
  ylab("Monthly Sales") +
  theme_bw()

month_cat <- orders %>%
  group_by(Order.Month, Category) %>%
  summarise(monthly_quantity=sum(Quantity))
ggplot(month_cat, aes(Order.Month, monthly_quantity, group=Category, color=Category)) +
  geom_line() +
  xlab("Month") +
  ylab("Daily Orders") +
  theme_bw()

month_cat <- orders %>%
  group_by(Order.Month, Category) %>%
  summarise(monthly_quantity=sum(Quantity))
ggplot(month_cat, aes(as.factor(Order.Month), monthly_quantity, group=Category, color=Category)) +
  geom_line() +
  xlab("Month") +
  ylab("Daily Orders") +
  theme_bw()

monthly <- orders %>%
  group_by(Order.Month) %>%
  summarise(monthly_quantity=sum(Quantity))
ggplot(monthly, aes(as.factor(Order.Month), monthly_quantity, group=1)) +
  geom_line(color="Blue") +
  xlab("Month") +
  ylab("Monthly Sales") +
  theme_bw()
