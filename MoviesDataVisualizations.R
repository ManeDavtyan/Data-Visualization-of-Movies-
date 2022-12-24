

# Importing libraries. 

library(ggplot2)
library(tidyverse)
library(dplyr)
library(plotly)
library(gganimate)


# Reading and manipulating data. 

df<- read.csv("movies.csv")
df<- df[df$release_date > '1979-12-31',]
df<- subset(df, select = -c(backdrop_path,poster_path,recommendations))
df$budget <- df$budget/1000000
df$revenue<- df$revenue/1000000
df$popularity <- df$popularity/100
df$profit <- df$revenue - df$budget
df<- df[df$title != "",]
df<- df[df$release_date != "",]
df<- df[df$genres != "",]
df<- df[df$runtime != "",]
df$year <- substr(df$release_date, 1, 4)
df$year <- as.numeric(df$year)
df_g<- separate_rows(df, genres, sep = "[-]", convert = FALSE) #separated genres for future 


### 1

#statuses of movies in our data
df_status <- df %>% group_by(status) %>% summarize(count = n())
plot_ly(df_status, x = ~status, y = ~count, type = 'bar',name = "status",  text = ~count, texposition = "auto",marker = list(color = c("green", "blue", "red", "goldenrod","magenta"))) %>%layout(title = "Movie Status by Counts")

### 2

#runtime distribution 

ggplotly(
  ggplot(df_g)+geom_histogram(aes(x=runtime, fill = genres),bins=30)+xlim(0,200)+ylim(0,20000)+labs(title="Runtime Distribution by Genres", x= "RunTime", y="Counts")
)

### 3

#vote average histogram per genre


ggplot(df_g)+geom_density(aes(x=vote_average, fill = genres))+facet_wrap(~genres) +labs(title="Average Vote Distribution by Genres")

ggplotly(
  ggplot(df_g)+geom_histogram(aes(x=vote_average, fill = genres))+xlim(0,10)+ylim(0,7500)+facet_wrap(~genres)+labs(title="Average Vote Histogram per Genre")
)


### 4

#posittive relationship between profit and popularity
ggplot(df,aes(x=profit, y=popularity, color = profit))+
  geom_point()+geom_smooth(method="lm", colour = "red")+labs(title="Relationship between Profit and Popularity")



### 5

#average profit by genre interactive barplot
df_g$profit = df_g$revenue - df_g$budget
ddf <- df_g %>% group_by(genres) %>% summarize(AverageProfit = mean(profit))
plot_ly(ddf, x = ~genres, y = ~AverageProfit, type = 'bar', texposition = "auto")%>%layout(title ="Average Profit per Genre")

### 6

#average budget in Millions $ by production company barplot interavtive for the richest 10 companies
df_prod<- separate_rows(df, production_companies, sep = "[-]", convert = FALSE)
ndf <- df_prod %>% group_by(production_companies) %>% summarize(avgbd = mean(budget))

# ordered average budgets by production companies
dat <- with(ndf, ndf[order(avgbd), ])
#visualizing last 10 rows, meaning the most budget having production companies
ndf<- tail(dat, n=10)

plot_ly(ndf, x = ~production_companies, y = ~avgbd, type = 'bar', texposition = "auto" )%>%layout(title=
                                                                                                    "Top 10 richest Producing Companies")





### 7

#pie chart of genres counts interactive
df_gg <- df_g %>% group_by(genres)%>% summarize(count = n())
df_gg %>% plot_ly(labels = ~genres, values = ~count)  %>% add_pie(hole = 0.3) %>% layout(title="Genre Counts")


### 8

#popularity of film depending on johny depp
johny <- df[grepl("Johnny Depp", df$credits),]

#average popularities of average votes
jj <- johny %>% group_by(year) %>% summarize(avgJohny = mean(vote_average))
dd<- df %>% group_by(year) %>% summarize(avgAll = mean(vote_average))

all_johny<-  na.omit(merge(x = dd, y = jj, by = "year", all = TRUE))

all_johny<- all_johny[rep(seq_len(nrow(all_johny)),times=2),]
all_johny<- tibble::rowid_to_column(all_johny, "id")
all_johny$vote_average <- all_johny$year
all_johny$vote_average[all_johny$id %in% c(1:35)] <- all_johny$avgAll[1:35]
all_johny$vote_average[!(all_johny$id %in% c(1:35))] <- all_johny$avgJohny[1:35]

all_johny$name <- all_johny$year
all_johny$name[all_johny$id %in% c(1:35)] <- "All movies"
all_johny$name[!(all_johny$id %in% c(1:35))] <- "Movies played by Johny"

all_johny<- subset(all_johny, select = -c(avgAll, avgJohny,id) )


JohnyDepp<- ggplot(all_johny, aes(x=year, y=vote_average,color = name))+geom_col(position="dodge")+facet_wrap(~name)+labs(title = "All Movie average votes VS Johnny Depp's Movies average votes ")

ggplotly(JohnyDepp)


### 9


#Hypothesis- Johnny Depp film ratings VS Dwayne Johnson film ratings

Johnny_Depp <- dplyr::filter(df, grepl('Johnny Depp', credits))
Dwayne_Johnson <- dplyr::filter(df, grepl('Dwayne Johnson', credits))

Dwayne_Johnson <- Dwayne_Johnson %>% filter(title != "Black Adam")
Dwayne_Johnson <- Dwayne_Johnson %>% filter(title != "DC League of Super-Pets")

Johnny_Depp_scat <- plot_ly(Johnny_Depp, type = "scatter", x = ~title, y = ~vote_average, color = ~budget, size = ~budget, text = ~paste("Budget:",  budget, "<br>Movie Title:",  title, "$<br>Average vote:", vote_average))%>% layout(title = "Scatterplot of Johnny Depp's films by rating", xaxis = list(showticklabels = FALSE, title = 'Movie Title'), yaxis = list(title = 'Average Vote'))
Johnny_Depp_scat
Dwayne_Johnson_scat <- plot_ly(Dwayne_Johnson, type = "scatter", x = ~title, y = ~vote_average, color = ~budget, size = ~budget, text = ~paste("Budget:",  budget, "<br>Movie Title:",  title, "$<br>Average vote:", vote_average))%>% layout(title = "Scatterplot of Dwayne Johnson's films by rating", xaxis = list(showticklabels = FALSE, title = 'Movie Title'), yaxis = list(title = 'Average Vote'))
Dwayne_Johnson_scat
#We can see, that movies with Dwayne Johnson in their cast have a bigger popularity within the critics, let's see if that's the case among the ordinary people.



### 10

Johnny_Depp_pop <- plot_ly(Johnny_Depp, type = "scatter", x = ~title, y = ~popularity, color = ~budget, size = ~budget, text = ~paste("Budget:",  budget, "<br>Movie Title:",  title, "$<br>Popularity Index:", popularity))%>% layout(title = "Scatterplot of Johnny Depp's films by popularity", xaxis = list(showticklabels = FALSE, title = 'Movie Title'), yaxis = list(title = 'Public Popularity'))
Johnny_Depp_pop

Dwayne_Johnson_pop <- plot_ly(Dwayne_Johnson, type = "scatter", x = ~title, y = ~popularity, color = ~budget, size = ~budget, text = ~paste("Budget:",  budget, "<br>Movie Title:",  title, "$<br>Popularity Index:", popularity))%>% layout(title = "Scatterplot of Dwayne Johnson's films by popularity", xaxis = list(showticklabels = FALSE, title = 'Movie Title'), yaxis = list(title = 'Public Popularity'))
Dwayne_Johnson_pop

#We can see, that within the ordinary people, the movies with Johnny Depp in the cast tend to have a higher popularity.




### 11

#Some might think, that most movies are made in english. Let's test if this hypothesis is true.


Movie_language <- plot_ly(df, labels = ~original_language, type = 'pie', textposition = 'inside', textinfo = 'label+percent', insidetextfont = list(color = '#FFFFFF'), marker = list(colors = colors, width = 1))
Movie_language <- Movie_language %>% layout(title = 'Pie Chart of the Original Languages',
                                            xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                                            yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

Movie_language

#As we can see, indeed, most movies are made in english, but we can see, there are around 30000 movies which were made in french and spanish and a considerable amount made in german, japanese, russian etc.



### 12

#movies about wars
war <- df[grepl("war", df$keywords),]
war$after <- war$year
war$after[war$year >=2011] <- "After 2011"
war$after[war$year < 2011] <- "Before 2011"



ggplot(data = war, aes(x = "", fill = after)) + geom_bar() +
  geom_text(stat = 'count', aes(label = ..count..),
            position = position_stack(vjust=0.5)) +
  coord_polar(theta='y') + theme_void()+labs(title = "Movies Produced after-before 2011 Syrian Civil War")



### 13

#movies about robots

robots <- df[grepl("robot", df$keywords),]
robots$after <- robots$year
robots$after[robots$year >=2016] <- "After 2016"
robots$after[robots$year < 2016] <- "Before 2016"



ggplot(data = robots, aes(x = "", fill = after)) + geom_bar() +
  geom_text(stat = 'count', aes(label = ..count..),
            position = position_stack(vjust=0.5), color = "white") +
  coord_polar(theta='y') + theme_void()+labs(title = "Movies Produced after-before 2016 creation of Sophia robot")




### 14

#most repeated keywords in Marvel industry
marvel <- df[grepl("Marvel", df$production_companies),]

marvel<- separate_rows(marvel, keywords, sep = "[-]", convert = FALSE)


t<- marvel %>% group_by(keywords) %>% summarize(count =length(keywords))
t<- t[t$count>2,]

MarvelKeywords<- t %>%ggplot(aes(y=keywords, x=count))+geom_col(color = "darkred", fill = "lightblue") +labs(title = "Most Frequently Used Keywords by Marvel")

ggplotly(MarvelKeywords)



### 15

superhero <- df[grepl("superhero", df$keywords),]


superhero$after <- superhero$year
superhero$after[superhero$year >= 2008] <- "After 2008"
superhero$after[superhero$year < 2008] <- "Before 2008"

#ggplotly made usual graph interactive

a<- ggplot(superhero)+geom_bar(aes(x= after, fill = after)) +labs(title = "Movies including 'superheros' after-before Marvels establishment (2008) ")
ggplotly(a)





### 16


armenian <- dplyr::filter(df, grepl('hy', original_language))
armenian_grouped <- armenian %>% group_by(year) %>%summarize(count = n())

armenian_per_year <- plot_ly(armenian_grouped, x = ~year, y = ~count,color=~year, type = 'bar', name = "year", text = ~paste("Number of movies:",  count, "<br>Year of release:",  year))%>% layout(title = "Year of production of Armenian movies", xaxis = list(showticklabels = FALSE, year = 'Year of production'), yaxis = list(title = 'Number of movies'))                       
armenian_per_year









