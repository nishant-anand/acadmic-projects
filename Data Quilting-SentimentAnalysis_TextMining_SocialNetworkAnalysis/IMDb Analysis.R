#Load packages and libraries
install.packages("dplyr")
install.packages("igraph")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("sentimentr")
install.packages("tm")
install.packages("reshape")
install.packages("reshape2")


library(dplyr)
library(igraph)
library(ggplot2)
library(tm)
library(sentimentr)
library(reshape) 
library(reshape2)

#Loading the data from local directory
setwd("~/Documents/R Workspace/Nishant/MIS SNA SENTIMENT IMDB")


#Movie data from 1900 to 2017 
movieData <- read.csv("IMDbMovie_Movies.csv")


#Search for IMDb id for Harry Potter and the Sorcerer's Stone 
sorcererStoneData<-movieData %>% filter(Title == "Harry Potter and the Sorcerer's Stone" )
imdbIDs<-sorcererStoneData[1,"imdbID"]
imdbIDs
# tt0241527


#Serch for the genre of movie -Harry Potter and the Sorcerer's Stone 
movieGenres <- read.csv("IMDbMovie_Genres.csv")
sorcererStoneGenres<-movieGenres %>% filter(movieGenres$imdbID == "tt0241527")
# Adventure Family Fantasy


# Filtering out movies with genre Adventure Family Fantasy
moviesWithGenreAFF<-movieGenres %>% filter(movieGenres$Genre %in%  c("Adventure","Family","Fantasy","War","Western")) 
moviesWithGenreAFFImdbID<-moviesWithGenreAFF %>% select(-X,-Genre)
selectedMovies<-movieData %>% filter (movieData$imdbID %in% unlist(moviesWithGenreAFFImdbID, use.names=FALSE)) 
selectedMovies<-selectedMovies  %>% select(Country,Runtime,Title,Type,Year,imdbID,imdbRating,imdbVotes)


# Joining both the tables
selectedMoviesJoined<-inner_join(selectedMovies,movieGenres, by =NULL,suffix = c(".imdbID", ".imdbID"))
selectedMoviesJoined<-selectedMoviesJoined %>% filter(Genre %in%  c("Adventure","Family","Fantasy","War","Western"))


# Genre Vs Year count
by_genre_year <- selectedMoviesJoined %>%
  count(Genre, Year)
by_genre_year$Year<-as.numeric(as.character(by_genre_year$Year))
#by_genre_year<-by_genre_year %>% filter(between(Year,2001,2003)) %>% order_by(Year)
#by_genre_year<-by_genre_year %>% filter(Year %in% c(2001) ) %>% order_by(Year)


#Different Gener over  the period of time 
by_genre_year_adventure<-by_genre_year %>% filter(Genre =="Adventure")
by_genre_year_family<-by_genre_year %>% filter(Genre =="Family")
by_genre_year_fantasy<-by_genre_year %>% filter(Genre =="Fantasy")
by_genre_year_war<-by_genre_year %>% filter(Genre =="War")
by_genre_year_western<-by_genre_year %>% filter(Genre =="Western")

# Plot IMDb Data - Number of Movies vs Year
ggplot(by_genre_year,aes(x=Year,y=n,color=Genre))+
  geom_smooth()+
  xlab("Year")+
  ylab("Number of Movies")+
  ggtitle("IMDb Data - Number of Movies vs Year")+
  geom_vline(xintercept = 2001,linetype="dashed", color = "black", size=0.5)+
  theme(plot.title = element_text(hjust = 0.4,face = "bold"))

##Comparing Genre ##
ggplot(by_genre_year,aes(x=Year,y=n,color=Genre))+
  geom_smooth()+
  xlab("Year")+
  ylab("Number of Movies")+
  ggtitle("IMDb Data - Comparing Genre")+
  geom_vline(xintercept = 2001,linetype="dashed", color = "black", size=0.5)+
  theme(plot.title = element_text(hjust = 0.4,face = "bold"))

# Each Genre(Adventure) VS Time
ggplot(by_genre_year_adventure,aes(x=Year,y=n,color=Genre))+
  geom_point()+
  geom_smooth()

# Each Genre(Family) VS Time
ggplot(by_genre_year_family,aes(x=Year,y=n,color=Genre))+
  geom_point()+
  geom_smooth()

# Each Genre(War) VS Time
ggplot(by_genre_year_war,aes(x=Year,y=n,color=Genre))+
  geom_point()+
  geom_smooth()

# Each Genre(Fantasy) VS Time
ggplot(by_genre_year_fantasy,aes(x=Year,y=n,color=Genre))+
  geom_point()+
  geom_smooth()

# Each Genre(Western) VS Time
ggplot(by_genre_year_western,aes(x=Year,y=n,color=Genre))+
  geom_point()+
  geom_smooth()



