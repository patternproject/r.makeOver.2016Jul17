## `````````````````````````````````````````````
#### Read Me ####
## `````````````````````````````````````````````
## Make over Monday Entry for Wk 29
## `````````````````````````````````````````````

## `````````````````````````````````````````````
#### Load Libraries ####
## `````````````````````````````````````````````
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr,ggplot2,tidyr,scales,grid,stringr,rvest)
pacman::p_load(RColorBrewer)
#pacman::p_load(ellipse)
pacman::p_load(ggthemes)
pacman::p_load(stats)
#pacman::p_load(plotly)
pacman::p_load(lubridate)

## `````````````````````````````````````````````

## `````````````````````````````````````````````
#### Constants ####
## `````````````````````````````````````````````
## color codes ####
col.grey = "#707070"
col.teal = "#368C8C"
col.blue = "#4682B4"
col.mid.green = "#98EFC1"
col.lig.green = "#B8FFD1"
col.dark.red = "darkred"
col.white = "white"

col.l.grey = "#D3D0CB"
col.m.grey = "#9FB1BC"
col.d.grey = "#6E8898"
col.d.blue = "#2E5266"
col.d.yellow = '#E2C044'
## point size####
size.l.point = 3
size.s.point = 1
## `````````````````````````````````````````````



## `````````````````````````````````````````````
#### Read Data ####
## `````````````````````````````````````````````
setwd("D:/2. Bianca/1. Perso/14. MakeoverMonday/27. 2016 Jul 17/r.makeOver.2016Jul17")

## df.master ####
df.master = read.csv(
  "2. Data/The Next to Die.csv",
  header = TRUE,
  stringsAsFactors = FALSE,
  na.strings = c("", "NA")
)
## `````````````````````````````````````````````

## `````````````````````````````````````````````
#### Manipulate Data ####
## `````````````````````````````````````````````
names(df.master) = tolower(names(df.master))

# master replica
df.1 = df.master

# setting correct data types
df.1$sex = as.factor(df.1$sex)
df.1$race = as.factor(df.1$race)
df.1$state = as.factor(df.1$state)
df.1$region = as.factor(df.1$region)
df.1$method = as.factor(df.1$method)
df.1$juvenile = as.factor(df.1$juvenile)
df.1$federal = as.factor(df.1$federal)
df.1$volunteer = as.factor(df.1$volunteer)
df.1$foreign.national = as.factor(df.1$foreign.national)

# http://www.noamross.net/blog/2014/2/10/using-times-and-dates-in-r---presentation-code.html
df.1$date2 = mdy(df.1$date)
df.1$year = year(df.1$date2)
# adding decades
# src: 
# http://stackoverflow.com/questions/35352914/floor-a-year-to-the-decade-in-r
df.1$decade = (df.1$year %/%10) *10

# use gender as level 1 category
# use decade and region as level 2 categories
df.2 = 
  df.1 %>%
  group_by(sex,decade,region) %>%
  summarize(count = n())
## `````````````````````````````````````````````


## `````````````````````````````````````````````
#### Visualize Data ####
## `````````````````````````````````````````````
g.1 = ggplot()

#g.1 = g.1 + geom_bar(data=df.2,aes(x=decade,y=count),  position = "dodge", stat="identity") + facet_grid(.~region)
#g.1 = g.1 + geom_bar(data=df.2,aes(x=decade,y=count,fill=sex),  position = "dodge", stat="identity") + facet_grid(.~region)
#g.1 = g.1 + geom_bar(data=df.2,aes(x=decade,y=count),  position = "dodge", stat="identity",colour="black", fill="#DD8888", width=1) + facet_grid(sex~region)
g.1 = g.1 + geom_bar(data=df.2,aes(x=decade,y=count),  position = "stack", stat="identity",colour="black", fill="#DD8888", width=1) + facet_grid(sex~region)
g.1


# g.2 = ggplot()
# g.2 = g.2 + geom_area(data=df.2,aes(x=decade,y=count),  position = "stack") + facet_grid(.~region)
# g.2


# explore further
# https://jepoirrier.org/2012/05/16/visualizing-categorical-data-in-mosaic-with-r/