shipData=read.csv("ShipData.csv")
 head(shipData,n=10)
summary(shipData)
hjstr(shipData)



shipData[, c("Age.at.Sale.Scale", "DWT.Scale", "Capesize.Scale")] <- scale(shipData[, c("Age.at.Sale", "DWT", "Capesize")])

shipData$DWTDifference<-round(abs(0.68917311-shipData$DWT.Scale),2)
shipData$DWTWeightRange<-round((shipData$DWTDifference/max(shipData$DWTDifference)),2)
shipData$DWTWeight<-round((shipData$DWTDifference/max(shipData$DWTDifference))*abs(cor(shipData$DWT,shipData$Price)),2)

shipData$AgeAtSaleDifference<-round(abs(-0.51668628-shipData$Age.at.Sale.Scale),2)
shipData$AgeAtSaleWeightRange<-round((shipData$AgeAtSaleDifference/max(shipData$AgeAtSaleDifference)),2)
shipData$AgeAtSaleWeightDifference<-round((shipData$AgeAtSaleDifference/max(shipData$AgeAtSaleDifference))*abs(cor(shipData$Age.at.Sale,shipData$Price)),2)


shipData$CapeSizeDifference<-round(abs(1.9346511-shipData$Capesize),2)
shipData$CapeSizeWeightRange<-round((shipData$CapeSizeDifference/max(shipData$CapeSizeDifference)),2)
shipData$CapeSizeWeight<-round((shipData$CapeSizeDifference/max(shipData$CapeSizeDifference))*abs(cor(shipData$Capesize,shipData$Price)),2)

shipData$TotalWeight<-shipData$DWTWeight+shipData$AgeAtSaleWeightDifference+shipData$CapeSizeWeight


shipData$AgeAtSaleDifference<-round(abs(11-shipData$Age.at.Sale),2)
shipData$AgeAtSaleWeightRange<-round((shipData$AgeAtSaleDifference/max(shipData$AgeAtSaleDifference)),2)
shipData$AgeAtSaleWeightDifference<-round((shipData$AgeAtSaleDifference/max(shipData$AgeAtSaleDifference))*abs(cor(shipData$Age.at.Sale,shipData$Price)),2)

shipData$DWTDifference<-round(abs(172-shipData$DWT),2)
shipData$DWTWeightRange<-round((shipData$DWTDifference/max(shipData$DWTDifference)),2)
shipData$DWTWeight<-round((shipData$DWTDifference/max(shipData$DWTDifference))*abs(cor(shipData$DWT,shipData$Price)),2)


shipData$CapeSizeDifference<-round(abs(12749-shipData$Capesize),2)
shipData$CapeSizeWeightRange<-round((shipData$CapeSizeDifference/max(shipData$CapeSizeDifference)),2)
shipData$CapeSizeWeight<-round((shipData$CapeSizeDifference/max(shipData$CapeSizeDifference))*abs(cor(shipData$Capesize,shipData$Price)),2)

shipData$TotalWeight<-shipData$DWTWeight+shipData$AgeAtSaleWeightDifference+shipData$CapeSizeWeight


shipData$TotalWeight<-round((shipData$TotalWeight/max(shipData$TotalWeight)),2)
d<- density(shipData$TotalWeight) # returns the density data
plot(d)

newdata <- shipData[order(shipData$TotalWeight),]
newDataFiltered<-newdata[newdata$TotalWeight<0.2,]  

mean(newDataFiltered$Price)
getwd()
setwd("/Users/nishantanand/Documents/R Workspace/STAT Group Project")
write.csv(newdata,"RankedShips.csv")
#shipData$CapeSizeWeight<-shipData$CapeSizeDifference*abs(cor(shipData$Capesize,shipData$Price))


qplot(data=shipData,x=shipData$YearBuilt,y=shipData$Price)

#shipData$CapeSizeWeight<-round((abs(mean(shipData$Capesize)-shipData$Capesize))/(48353.0-2027.0),2)


#shipData$CapeSizeDifference<-(shipData$Capesize-min(shipData$Capesize))/(max(shipData$Capesize)-min(shipData$Capesize))
#shipData$CapeSizeWeight<-shipData$CapeSizeDifference*abs(cor(shipData$Capesize,shipData$Price))



#Filter out non numeric Data
shipDataOrg<-shipData
shipData$Vessel=NULL
shipData$SaleDate=NULL

#Correlation for Nonnumeric Data
round(cor(shipData),2)
#Filtering Out Year built as its stronglly correalated with AgeAtSale
shipData$YearBuilt=NULL
#Summary of the dataSet
summary(shipData)
sd(shipData$Age.at.Sale)
sd(shipData$Price)#33.89
sd(shipData$DWT)#17.65
sd(shipData$Capesize)#2499.30
nrow(shipData)
#Filtering out the Ships between age 10 and 12 inclusive
filter1<-shipDataOrg[shipData$Age.at.Sale >(11-2) & shipData$Age.at.Sale <(11+2) ,]
nrow(filter1)
filter2<-filter1[filter1$DWT >172-3 & filter1$DWT <172+3,]
#nrow(filter2)
#filter2<-filter1[filter1$DWT >(mean(shipData$DWT)-sd(shipData$DWT)) & filter1$DWT <(mean(shipData$DWT)+sd(shipData$DWT)),]
#nrow(filter2)

filter3<-filter2[filter2$Capesize >(mean(shipData$Capesize)-sd(shipData$Capesize)) & filter2$Capesize <(mean(shipData$Capesize)+sd(shipData$Capesize)),]
nrow(filter3)
#Correlation
#Correlation with YearBuilt
cor(shipData$YearBuilt,shipData$Price)
#Correlation with ageOfSale
cor(shipData$Age.at.Sale,shipData$Price)
#Correlation with dwt
cor(shipData$DWT,shipData$Price)
#Correlation with capesize
cor(shipData$Capesize,shipData$Price)

sd(shipData$Age.at.Sale)#6.33
mean(shipData$Age.at.Sale)#14.27
filter1<-shipData[shipData$Age.at.Sale >(11-2) & shipData$Age.at.Sale <(11+2) ,]
qplot(data=filter1 ,x=Age.at.Sale, y=Price,size=10)

sd(filter1$DWT)#9.85
mean(filter1$DWT)#162
filter2<-filter1[filter1$DWT >(162-9.85) & filter1$DWT <(162+9.85) ,]

sd(filter2$Capesize)#9.85
mean(filter2$Capesize)#162
filter3<-filter2[filter2$Capesize >(6200.2-2014.214) & filter2$Capesize <(6200.2+2014.214) ,]


sd(shipData$DWT)
sd(shipData$YearBuilt)
sd(shipData$Capesize)

qplot(data=shipData ,x=Age.at.Sale, y=Price,size=10)


shipDataF1<-shipData[shipData]




date=data[,1]
date

sale_price=data[,3]
date_test="07-Jan"
cor(date,sale_price)
formattedDates <- as.Date(date_test,
                          format = "%y-%b")
?strptime
date_test1=paste(date_test,"-01")
ap<-strptime(date_test1,"%y-%b -%d")
hello<-as.numeric(ap)
cor(hello,sale_price)


======
  newData=read.csv("macUpdated1.csv")
month=newData[,8]
year=newData[,9]
sale_priceNew=newData[,3]
year_built=newData[,4]
ageOfSale=newData[,5]
dwt=newData[,6]
capesize=newData[,7]

#Correlation
#Correlation with Month
cor(month,sale_priceNew)
#Correlation with Year
cor(year,sale_priceNew)
#Correlation with YearBuilt
cor(year_built,sale_priceNew)
#Correlation with ageOfSale
cor(ageOfSale,sale_priceNew)
#Correlation with dwt
cor(dwt,sale_priceNew)
#Correlation with capesize
cor(capesize,sale_priceNew)

#Mean
mean(month)
mean(year)
mean(ageOfSale)
mean(dwt)
mean(capesize)
mean(sale_priceNew)
mean(year_built)

ncol(data)
print(colnames())
for(j in c(data)){
  mean(data)
  print(mean(data[,j]))
}

data %>% 
  colnames()
#SD
sd(month)
sd(year)
sd(ageOfSale)
sd(dwt)
sd(capesize)
sd(sale_priceNew)

install.packages("rmarkdown")
tinytex::install_tinytex()
