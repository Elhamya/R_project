# Load the gapminder and dplyr package
library(gapminder)
library(dplyr)

# Look at the gapminder dataset
gapminder

Note that each time, you'll put the pipe %>% at the end of the first line (like gapminder %>%); putting the pipe at the beginning of the second line will throw an error.
filter verb, for extracing a subset of observations based on the condition
arrange verb, sorts the observations in a dataset, in acs or desc order based on one of its variables

use the pipe operator (%>%) to combine multiple dplyr verbs in a row.

# Filter for the year 1957, then arrange in descending order of population

gapminder %>% 
filter(year==1957) %>%
arrange(desc(pop))

mutate verb: suppose you want to change one of the variables in your dataset based on the other ones, or suppose you want to add a new variable
thats often necessary during data processing and cleaning

# Use mutate to change lifeExp to be in months
gapminder %>% mutate(lifeExp =12 * lifeExp)
# Use mutate to create a new column called lifeExpMonths
gapminder %>% mutate(lifeExpMonths =12 * lifeExp)

# find the countries with the highest life expectancy, in months, in the year 2007.
gapminder %>% 
mutate(lifeExpMonths= lifeExp*12) %>%
filter(year==2007) %>%
arrange(desc(lifeExpMonths)) 

so far we've engaged with the results only as a table printed out from our code, often a better way to presenta nad understand this kind of data is as a graph, for this purpose using the ggplot2 package for data visualization.

visualization and data wrangling(the process of cleaning, transforming, and organizing raw data) are often intertwined subsets of the gapminder datasets then save the filtered data as a new data frame.

library(ggplot2)
gapminder_2007<- gapminder %>% filter(year==2007) 
ggplot(gapminder_2007, aes(x=gdpPerCap, y=lifeExp)) + geom_point()

* higher income countries tend to have higher life expectancy
a lot of countries get crampt into the left most part of the x axis> this is because the distribution of GDP per capita varies across many orders of magnitude (e.g., population, income, gene counts, etc.)> it's useful to work with logaritmic scale

library(ggplot2)

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10()    # Apply log10 to x-axis

on this scale the relationship looks more linear and can more easily distinguish the countries at the lower end of the espectrum
to communicate even more information to scatter plot by adding two more aesthetic: color and size

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color= continent, size=pop)) +
  geom_point() +
  scale_x_log10()    # Apply log10 to x-axis

for exploring more details based on chategorical variables, we can dividing plot into subplot which is called faceting

ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp))+  geom_point()+  scale_x_log10()+  facet_wrap(~ continent)

analysis will usually involve a cycle between data transformation and visualization

summarize verb: summarize() turns many rows into one

gapminder %>%  filter(year ==2007)%>%  summarize(meanLifeExp = mean(lifeExp), totalPop =sum(pop))

getting one row for each year:

library(gapminder)
library(dplyr)
library(ggplot2)

# Summarize the median GDP and median life expectancy per continent in 2007
by_continent_2007 <- 
gapminder %>% filter(year==2007) %>% group_by(continent) %>%
summarize(medianLifeExp=median(lifeExp), medianGdpPercap=median(gdpPercap))

# Use a scatter plot to compare the median GDP and median life expectancy
ggplot(by_continent_2007, aes(x=medianGdpPercap, y=medianLifeExp), color=continent)+geom_point()+
expand_limits(y=0)

line plot: showing change over time
bar plot: good at comparing statistics for each of several categories
histograms: describe the distribution of a one_dimentional numeric variables> A histogram is useful for examining the distribution of a numeric variable.
box plot: comparing the distribution of values across discrete categories > x=categorical variable, y= numerical value that we tend to compare,
# Summarize the median gdpPercap by year, then save it as by_year
by_year<- gapminder %>% group_by(year) %>% summarize(medianGdpPercap=median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap over time
ggplot(by_year, aes(x=year, y=medianGdpPercap))+
geom_line()+
expand_limits(y=0)

# Summarize the median gdpPercap by year & continent, save as by_year_continent
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap by continent over time
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, color = continent)) +
  geom_line() +
  expand_limits(y = 0)





# Summarize the median gdpPercap by continent in 1952
by_continent<-gapminder%>% 
filter(year==1952)%>%
group_by(continent)%>%
summarize(medianGdpPercap= median(gdpPercap))
by_continent
# Create a bar plot showing medianGdp by continent
ggplot(by_continent, aes(x=continent, y=medianGdpPercap))+
geom_col()+
expand_limits(y=0)

# distribution of lifeExp acroos countries in 2007, every bar represants a bin of life expectancies and the hight represants how many countries fall into that bin, we can see most countries fall into 70 and 80 years, in some cases you may need to put x axis on a log scale for to be understandable> scale_x_log10()











