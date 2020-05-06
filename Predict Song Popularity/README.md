# Song Popularity Prediction

## INTRODUCTION
Music is omnipresent. 
There are millions of songs at everyone’s fingertips. 
Users can typically listen to a variety of songs tailored to their personal tastes and preferences. 
There are many stakeholders who would want to predict song popularity like music apps like Spotify and Pandora, venues, advertisements, news, music distributors etc.


## Problem Statement and Implications 
Problem Statement: To identify the popularity of a given song

We chose this problem to understand the features that are important in predicting the popularity of a song
This can help an artist to understand if their song is going to be popular or not.

Using song features, build a model which can predict if a given song will be above or below the mean of song popularity scores of the data (0.487166).We chose 6 classification algorithms in order to compare the results and see which one gives us optimal results.


## Data
Million Song Dataset (MSD) is a freely available collection of audio features and metadata for a million contemporary tracks 
From The Echo Nest (now owned by Spotify) 
Size of the dataset - 1GB
One Million Songs 
53 features and 1M records


## Data Preprocessing
Extracted all the metadata using Python and created a CSV summary file 
Each song has 53 features such as Mode, Tempo, Duration, Title, End of Fade In, etc.,
Traditional data cleansing 
Removed records that are a missing year or song popularity metric 
Removed Variables with zero variance, zero cardinality, and high cardinality 
Removed columns which had more than 50% missing data
Removed columns which were not significant for our analysis

![](images/Picture1.png)

## Data Exploration
After data cleansing, left with 306297 rows 

Correlation matrix: 
We can see a high correlation between
duration and  start_of_fade_out
artist_familiarity and artist_hotness
song_hotness with artist_familiarity and artist_hotness


## Feature Selection
Extra Trees Classifier to determine feature importance score  
We have removed variables which are not significant to our analysis :
Mode, time_signature, key
By removing these variables we were able to achieve high performance because their p-value is high and does not contribute significantly to our model
We have verified these features using RFE (Recursive Feature Elimination)


## Model Evaluation
Logistic Regression gives the best accuracy of all the models tried
It also had the best Cross-validation Score and  Accuracy (0.69 and 0.69)
Parameters for model building
For Random forest: 100 decision trees
We tried altering the parameters like max_depth, n_estimators to maximize accuracy


## Conclusion
Predicted song popularity based on song features 
Artist familiarity, Artist Hotness, Loudness, Tempo, End of Fade In are the top five features 
Logistic Regression gave the best results 


## Limitations
Music is a complex item to analyze as it contains many layers of dependent and independent factors that can influence a user into making some random-looking choices. 
The approach presented here to solve the problem was limited by the computational resources available.
We removed variables based on statistical techniques but based on literacy survey we could have retained a few in order to get more optimal results.


## Future Work
We can do sentiment analysis on the lyrics and include genres to build the model.
It would be interesting to see the use of some of the open-source libraries, like Apache Mahout and Apache Hadoop, to facilitate the solving of bigger matrices than what is encountered here. 
We can segment users based on their preferences and pick songs accordingly for them
