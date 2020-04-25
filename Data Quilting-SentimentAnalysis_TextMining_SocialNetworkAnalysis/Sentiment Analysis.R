# Loading packages and library
install.packages("dplyr")
install.packages("igraph")
install.packages("ggplot2")
install.packages("sentimentr")
install.packages("tm")
install.packages("tidytext")

library(dplyr)
library(igraph)
library(ggplot2)
library(tm)
library(sentimentr)
library(tidytext)
# Loading the data from local directory
setwd("~/Documents/R Workspace/Nishant/MIS SNA SENTIMENT IMDB")
scripts <- read.csv("Harry Potter 1 Script.csv")


############################### Harry's Sentiment through the movie ###############################################

harryScript<-scripts %>% filter(Speaker=="Harry")
harryScript<-harryScript %>% select(-Recipient)
tokenHarry <- harryScript %>%  
  mutate(dial=as.character(harryScript$Dialoge)) %>%
  unnest_tokens(word, dial)

sentimentsHarry <- tokenHarry %>% 
  inner_join(get_sentiments("afinn")) %>%
  group_by(Scene) 

#Dividing the script into 10 parts 
firstHarry<-aggregate(sentimentsHarry[,5],list(between(sentimentsHarry$Scene,1,7)), mean)
secondHarry<-aggregate(sentimentsHarry[,5],list(between(sentimentsHarry$Scene,8,14)), mean)
thirdHarry<-aggregate(sentimentsHarry[,5],list(between(sentimentsHarry$Scene,15,21)), mean)
fourthHarry<-aggregate(sentimentsHarry[,5],list(between(sentimentsHarry$Scene,22,28)), mean)
fifthHarry<-aggregate(sentimentsHarry[,5],list(between(sentimentsHarry$Scene,29,35)), mean)
sixthHarry<-aggregate(sentimentsHarry[,5],list(between(sentimentsHarry$Scene,36,42)), mean)
seventhHarry<-aggregate(sentimentsHarry[,5],list(between(sentimentsHarry$Scene,43,49)), mean)
eighthHarry<-aggregate(sentimentsHarry[,5],list(between(sentimentsHarry$Scene,50,56)), mean)
ninethHarry<-aggregate(sentimentsHarry[,5],list(between(sentimentsHarry$Scene,56,63)), mean)
tenthHarry<-aggregate(sentimentsHarry[,5],list(between(sentimentsHarry$Scene,63,70)), mean)

harrySentimentVsScene<-data.frame(c(10,20,30,40,50,60,70,80,90,100),c(firstHarry[2,2],secondHarry[2,2],thirdHarry[2,2],fourthHarry[2,2],fifthHarry[2,2],sixthHarry[2,2],seventhHarry[2,2],eighthHarry[2,2],ninethHarry[2,2],tenthHarry[2,2]))
colnames(harrySentimentVsScene)<-c("Scene","Sentiment")
plot(harrySentimentVsScene$Scene,harrySentimentVsScene$Sentiment,type="l")
ggplot(data=harrySentimentVsScene, aes(x=harrySentimentVsScene$Scene,y=harrySentimentVsScene$Sentiment))+
  geom_point(color="deepskyblue3")+
  geom_line()+
  geom_smooth()+
  xlab("Movie")+
  ylab("Sentiment")+
  ggtitle("Harry's Sentiment through the Movie")+
  theme(plot.title = element_text(hjust = 0.4,face = "bold"))



############################# Rons Sentiment through the movie #################################################

ronScript<-scripts %>% filter(Speaker=="Ron")
ronScript<-ronScript %>% select(-Recipient)
tokenRon <- ronScript %>%  
  mutate(dial=as.character(ronScript$Dialoge)) %>%
  unnest_tokens(word, dial)

sentimentsRon <- tokenRon %>% 
  inner_join(get_sentiments("afinn")) %>%
  group_by(Scene) 

#Dividing the script into 10 parts 
firstRon<-aggregate(sentimentsRon[,5],list(between(sentimentsRon$Scene,1,7)), mean)
secondRon<-aggregate(sentimentsRon[,5],list(between(sentimentsRon$Scene,8,14)), mean)
thirdRon<-aggregate(sentimentsRon[,5],list(between(sentimentsRon$Scene,15,21)), mean)
fourthRon<-aggregate(sentimentsRon[,5],list(between(sentimentsRon$Scene,22,28)), mean)
fifthRon<-aggregate(sentimentsRon[,5],list(between(sentimentsRon$Scene,29,35)), mean)
sixthRon<-aggregate(sentimentsRon[,5],list(between(sentimentsRon$Scene,36,42)), mean)
seventhRon<-aggregate(sentimentsRon[,5],list(between(sentimentsRon$Scene,43,49)), mean)
eighthRon<-aggregate(sentimentsRon[,5],list(between(sentimentsRon$Scene,50,56)), mean)
ninethRon<-aggregate(sentimentsRon[,5],list(between(sentimentsRon$Scene,56,63)), mean)
tenthRon<-aggregate(sentimentsRon[,5],list(between(sentimentsRon$Scene,63,70)), mean)

ronSentimentVsScene<-data.frame(c(10,20,30,40,50,60,70,80,90,100),c(firstRon[2,2],secondRon[2,2],thirdRon[2,2],fourthRon[2,2],fifthRon[2,2],sixthRon[2,2],seventhRon[2,2],eighthRon[2,2],ninethRon[2,2],tenthRon[2,2]))
colnames(ronSentimentVsScene)<-c("Scene","Sentiment")
plot(ronSentimentVsScene$Scene,ronSentimentVsScene$Sentiment,type="l")

ggplot(data=ronSentimentVsScene, aes(x=ronSentimentVsScene$Scene,y=ronSentimentVsScene$Sentiment))+
  geom_point(color="deepskyblue3")+
  geom_line()+
  geom_smooth()+
  xlab("Movie")+
  ylab("Sentiment")+
  ggtitle("Ron's Sentiment through the Movie")+
  theme(plot.title = element_text(hjust = 0.4,face = "bold"))

############################# Hermione Sentiment through the movie #################################################

hermioneScript<-scripts %>% filter(Speaker=="Hermione")
hermioneScript<-hermioneScript %>% select(-Recipient)
tokenHermione <- hermioneScript %>%  
  mutate(dial=as.character(hermioneScript$Dialoge)) %>%
  unnest_tokens(word, dial)

sentimentsHermione <- tokenHermione %>% 
  inner_join(get_sentiments("afinn")) %>%
  group_by(Scene) 

#Dividing the script into 10 parts 
firstHermione<-aggregate(sentimentsHermione[,5],list(between(sentimentsHermione$Scene,1,7)), mean)
secondHermione<-aggregate(sentimentsHermione[,5],list(between(sentimentsHermione$Scene,8,14)), mean)
thirdHermione<-aggregate(sentimentsHermione[,5],list(between(sentimentsHermione$Scene,15,21)), mean)
fourthHermione<-aggregate(sentimentsHermione[,5],list(between(sentimentsHermione$Scene,22,28)), mean)
fifthHermione<-aggregate(sentimentsHermione[,5],list(between(sentimentsHermione$Scene,29,35)), mean)
sixthHermione<-aggregate(sentimentsHermione[,5],list(between(sentimentsHermione$Scene,36,42)), mean)
seventhHermione<-aggregate(sentimentsHermione[,5],list(between(sentimentsHermione$Scene,43,49)), mean)
eighthHermione<-aggregate(sentimentsHermione[,5],list(between(sentimentsHermione$Scene,50,56)), mean)
ninethHermione<-aggregate(sentimentsHermione[,5],list(between(sentimentsHermione$Scene,56,63)), mean)
tenthHermione<-aggregate(sentimentsHermione[,5],list(between(sentimentsHermione$Scene,63,70)), mean)

hermioneSentimentVsScene<-data.frame(c(10,20,30,40,50,60,70,80,90,100),c(firstHermione[2,2],secondHermione[2,2],thirdHermione[2,2],fourthHermione[2,2],fifthHermione[2,2],sixthHermione[2,2],seventhHermione[2,2],eighthHermione[2,2],ninethHermione[2,2],tenthHermione[2,2]))
colnames(hermioneSentimentVsScene)<-c("Scene","Sentiment")
plot(hermioneSentimentVsScene$Scene,hermioneSentimentVsScene$Sentiment,type="l")
ggplot(data=hermioneSentimentVsScene, aes(x=hermioneSentimentVsScene$Scene,y=hermioneSentimentVsScene$Sentiment))+
  geom_point(color="deepskyblue3")+
  geom_line()+
  geom_smooth()+
  xlab("Movie")+
  ylab("Sentiment")+
  ggtitle("Hermione's Sentiment through the Movie")+
  theme(plot.title = element_text(hjust = 0.4,face = "bold"))

############################## Full Movie Sentiment ################################################

fullMovieScript<-scripts
fullMovieScript<-fullMovieScript %>% select(-Recipient)
tokenFullMovie <- fullMovieScript %>%  
  mutate(dial=as.character(fullMovieScript$Dialoge)) %>%
  unnest_tokens(word, dial)

sentimentsFullMovie <- tokenFullMovie %>% 
  inner_join(get_sentiments("afinn")) %>%
  group_by(Scene) 

#Dividing the script into 10 parts 
firstFullMovie<-aggregate(sentimentsFullMovie[,5],list(between(sentimentsFullMovie$Scene,1,7)), mean)
secondFullMovie<-aggregate(sentimentsFullMovie[,5],list(between(sentimentsFullMovie$Scene,8,14)), mean)
thirdFullMovie<-aggregate(sentimentsFullMovie[,5],list(between(sentimentsFullMovie$Scene,15,21)), mean)
fourthFullMovie<-aggregate(sentimentsFullMovie[,5],list(between(sentimentsFullMovie$Scene,22,28)), mean)
fifthFullMovie<-aggregate(sentimentsFullMovie[,5],list(between(sentimentsFullMovie$Scene,29,35)), mean)
sixthFullMovie<-aggregate(sentimentsFullMovie[,5],list(between(sentimentsFullMovie$Scene,36,42)), mean)
seventhFullMovie<-aggregate(sentimentsFullMovie[,5],list(between(sentimentsFullMovie$Scene,43,49)), mean)
eighthFullMovie<-aggregate(sentimentsFullMovie[,5],list(between(sentimentsFullMovie$Scene,50,56)), mean)
ninethFullMovie<-aggregate(sentimentsFullMovie[,5],list(between(sentimentsFullMovie$Scene,56,63)), mean)
tenthFullMovie<-aggregate(sentimentsFullMovie[,5],list(between(sentimentsFullMovie$Scene,63,70)), mean)

FullMovieSentimentVsScene<-data.frame(c(10,20,30,40,50,60,70,80,90,100),c(firstFullMovie[2,2],secondFullMovie[2,2],thirdFullMovie[2,2],fourthFullMovie[2,2],fifthFullMovie[2,2],sixthFullMovie[2,2],seventhFullMovie[2,2],eighthFullMovie[2,2],ninethFullMovie[2,2],tenthFullMovie[2,2]))
colnames(FullMovieSentimentVsScene)<-c("Scene","Sentiment")
plot(FullMovieSentimentVsScene$Scene,FullMovieSentimentVsScene$Sentiment,type="l")
ggplot(data=FullMovieSentimentVsScene, aes(x=FullMovieSentimentVsScene$Scene,y=FullMovieSentimentVsScene$Sentiment))+
  geom_point(color="deepskyblue3")+
  geom_line()+
  geom_smooth()+
  xlab("Scene")+
  ylab("Sentiment")+
  ggtitle("Sentiment through the Movie")+
  theme(plot.title = element_text(hjust = 0.4,face = "bold"))


############################# All characters sentiment in single plot ################
ggplot()+
  geom_smooth(data=ronSentimentVsScene, aes(x=ronSentimentVsScene$Scene,y=ronSentimentVsScene$Sentiment), color = "blue")+
  geom_smooth(data=harrySentimentVsScene, aes(x=harrySentimentVsScene$Scene,y=harrySentimentVsScene$Sentiment), color = "red")+
  geom_smooth(data=hermioneSentimentVsScene, aes(x=hermioneSentimentVsScene$Scene,y=hermioneSentimentVsScene$Sentiment), color = "green")+
  xlab("Scene")+
  ylab("Sentiment")+
  ggtitle("Sentiment through the Movie")+
  theme(plot.title = element_text(hjust = 0.4,face = "bold"))




