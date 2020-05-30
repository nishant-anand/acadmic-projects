#Load the required packages
library("FNN") 
install.packages("FNN")
library("caret") 
install.packages("caret")
install.packages("magrittr") # package installations are only needed the first time you use it
install.packages("dplyr")    # alternative installation of the %>%
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr) 


#Read a file from the local directory 
data_reg=read.csv("ShipData.csv")
backupData<-data_reg
#Check the first 6 rows of the data set
head(data_reg)

#Setting up the dataset for KNN Regression - Remove unnecessary columns
data_reg$SaleDate<-NULL
data_reg$Vessel<-NULL
data_reg$YearBuilt<-NULL
data_reg$Sale.Month<-NULL
data_reg$Sale.Year<-NULL

#Store the column to be predicted in another variable
price_outcome <- data_reg %>% select(Price)

#Remove the column to be predicted from the main dataframe as its already stored  in another variable
data_reg <- data_reg %>% select(-Price)

#Scale the dataset having independent variables using "scale" function
data_reg[, c("Age.at.Sale", "DWT", "Capesize")] <- scale(data_reg[, c("Age.at.Sale", "DWT", "Capesize")])

#Test the model with existing data using train and test model
# 80% of the sample size
set.seed(1234)
smp_size <- floor(0.70 * nrow(data_reg))
train_ind <- sample(seq_len(nrow(data_reg)), size = smp_size)

# creating test and training sets that contain all of the predictors
reg_pred_train <- data_reg[train_ind, ]
reg_pred_test <- data_reg[-train_ind, ]

abs_outcome_train <- price_outcome[train_ind, ]
abs_outcome_test <- price_outcome[-train_ind, ]

reg_results <- knn.reg(reg_pred_train, reg_pred_test, abs_outcome_train, k = 5)
print(reg_results)
plot(abs_outcome_test, reg_results$pred,type="p",main="K Nearest Neighbour Plot for Ship Price", xlab="Original Price", ylab="Predicted Price")

tot<-((abs_outcome_test-reg_results$pred)^2)

sqrt(sum(tot)/15)

install.packages("ggvis")
library(ggvis)

# Iris scatter plot
ggvis(data_reg$Price, data_reg$Age.at.Sale) %>% layer_points()
#Predict the price for betperformer
library("FNN") 
install.packages("FNN")
data_reg=read.csv("ShipData.csv")
data_reg$SaleDate<-NULL
data_reg$Vessel<-NULL
data_reg$YearBuilt<-NULL
data_reg$Sale.Month<-NULL
data_reg$Sale.Year<-NULL
price_outcome <- data_reg %>% select(Price)
data_reg <- data_reg %>% select(-Price)
data_reg[, c("Age.at.Sale", "DWT", "Capesize")] <- scale(data_reg[, c("Age.at.Sale", "DWT", "Capesize")])
data_predict <- data.frame("Age.at.Sale" = 11, "DWT" = 172, "Capesize" = 12479)
data_predict[, c("Age.at.Sale", "DWT", "Capesize")] <- scale(data_reg[, c("Age.at.Sale", "DWT", "Capesize")])
set.seed(1234)
smp_size <- floor(1 * nrow(data_reg))
train_ind <- sample(seq_len(nrow(data_reg)), size = smp_size)
reg_pred_train <- data_reg[train_ind, ]
reg_pred_test <-data_predict
abs_outcome_train <- price_outcome[train_ind, ]
abs_outcome_test <-100
reg_results <- knn.reg(reg_pred_train, reg_pred_test, abs_outcome_train, k = 5)
print(reg_results)
plot(abs_outcome_test, reg_results$pred,type="p",main="K Nearest Neighbour Plot for Ship Price", xlab="Original Price", ylab="Predicted Price")
plot(reg_results)
