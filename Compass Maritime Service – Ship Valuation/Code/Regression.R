install.packages("caTools")
library(caTools)
install.packages("ggplot2")
library(ggplot2)
install.packages("dyplr")
library(dplyer)
install.packages("gghighlight")
library(gghighlight)
########################################
####Training Data######################
shipData<-read.csv("ShipData.csv")



head(shipData)
shipData<-shipData %>% select(-SaleDate,-Vessel,-YearBuilt)
pairs(shipData)
set.seed(1234)
split = sample.split(shipData$Price, SplitRatio =0.70)
training_set = subset(shipData, split == TRUE)
test_shipData =subset(shipData, split== FALSE)
#########Test Set#####################



test_shipData = read.csv("ShipData-Test.csv")
#test_shipDataAll = read.csv("ShipData-TestAll.csv")
#head(test_shipData)
#test_shipData<-test_shipData %>% select(-SaleDate,-Vessel)
#test_shipDataAll<-test_shipDataAll %>% select(-SaleDate,-Vessel)

########## Regression ################
regressor<-lm(formula=Price ~ Capesize+Age.at.Sale+DWT,data=training_set)
summary(regressor)
confint(regressor)
regressor$/mean(training_set$Price)
predictedPrice<-predict(regressor,newdata = test_shipData,interval="confidence")
summary(predictedPrice)
predictedPriceAll<-predict(regressor,newdata = test_shipData)

newDataFrame<-data.frame(test_shipData$Price,predictedPrice,test_shipData$Age.at.Sale)

d<- density(shipData$Price) # returns the density data
plot(d)
plot(hist(shipData$Price))
hist(shipData$Price, 
     main="Histogram for Price", 
     xlab="Price", 
     border="Black", 
     col="deepskyblue3",
     xlim=c(20,160),
     las=1, 
     breaks=20)

ggplot(data=newDataFrame, aes(x=test_shipData.Price,y=fit))+
  geom_point(color="deepskyblue3")+
  geom_abline()+
  geom_smooth()+
  xlab("Price")+
  ylab("Predicted Price")


plot(predictedPrice,test_shipData$Price)

plot(lm(dist~speed,data=cars))

abline(lm(test_shipData$Price~predictedPrice))
######### Visualization ##############
ggplot() +
  
  geom_point(aes(x=training_set$Age.at.Sale,y=training_set$Price),
             colour="red")+
  geom_line(aes(x=training_set$Age.at.Sale,y=predict(regressor,newdata = training_set)),
            colour="blue")+
  ggtitle('Price vs AGE')+
  xlab('Price')
  ylab('Others')

#######################################
shipData<-read.csv("ShipData.csv")
  summary(shipData)
  
  boxplot(shipData$Age.at.Sale,horizontal=FALSE)
  boxplot.stats(shipData$Capesize)
  scatter.smooth(shipData$DWT)
  y=rnorm(shipData$DWT,mean = mean(shipData$DWT),sd(shipData$DWT))
  
  x <- seq(1,48,by =1) 
  plot(x,y)
  
  
length(x)  
length(y)

head(shipData)
shipData<-shipData %>% select(-SaleDate ,-Vessel,-YearBuilt,-Sale.Month,-Sale.Year)
mean(shipData$Capesize)
sd(shipData$Capesize)
summary(shipData)

#########################3
regressor$residuals<-regressor %>% filter()
summary(regressor$residuals)
sd(regressor$residuals)

125.83-3.944

125.83+5.33


