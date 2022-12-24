# Data-Visualization-of-Movies-

## Overview

The majority of world’s entire population loves watching movies, following the actors and future updates of the production companies. But not all people have an idea about their favorite movies’ profits or popularity in a large worldwide scale. Our project aims to show people some fresh facts about film industry via data visualizations. We have taken a movie data set with more than 700,000 rows, cleaned and prepared it for later modifications and visualizations.

## Research Methodology

The data about the movies was taken from the well-known web page “Kaggle”. Our data is in .csv format, which made the project a little easy to work on. We have read the original “csv” format downloaded from kaggle, and found out that the data contains information about all movies shot between 1900s and even future planned movies till 2100s. The following libraries were used for the analyses -> ggplot2, dplyr, tidyverse, plotly, flexdashboard.
Mostly, the project is done in R programming language, RStudio specifically. The dashboard of the graphs in the project can be observed with the help of the library flexdashboard, R.

## Literature Review

The project itself represents some statistical analysis of the data in order to retain or reject the given hypothesis. We will talk about the hypothesis below. The main data was taken from the following source “https://www.kaggle.com/datasets/akshaypawar7/millions-of- movies?select=movies.csv”. Several reports and articles were examined before starting the project. Mostly we have used the materials of DS116:Data Visualization, Fall2022, AUA course. Online sources and Google also were sources for the basic knowledge about the data set’s variables, hypothetical ideas and code structures.
There are many datasets that contain different insights on movies, and even more papers and exploratory work around those data sets. Some of them give interesting ideas for data exploration and visualizaton. For example the Movies Daily Update Dataset contains more than 700,000 metadata on both released and unreleased movies, which also has a daily update and has several notebooks that have done an Exploratory Data Analysis (EDA) on the data set. The notebooks presented for the mentioned Kaggle data set do not have deep EDA done on the data. Some show the distributions of several columns, and others have done Machine Learning (ML) projects on it and got recommendation systems using similarity algorithms on the vectorized data. Another interesting project that has done an EDA on movie data sets is published on the Jovian platform by the International School of AI and Data Science. The EDA shows analysis on genres, movie duration, the relationship with the rating etc.. For example, according to the project the movies with a genres Action, Adventure, or Sci-Fi are more likely to generate high revenue. Also, the author suggests that dramas are most likely appreciated by critics and generally have good ratings. Another curious fact from the current EDA that we also referred to in our work is that movie runtime matters. The current work shows that movies with a duration of 90 to 140 minutes are more liked by viewers. Another project that has insights into movie datasets is the Data Analysis from Movie Dataset by Ti-Chung Cheng, where the author used a data set containing over 20 million ratings across 27278 movies and covers rating from a period from 1995 to 2015. The author uses ML techniques to cluster the data set by genres and gives insights on user types that prefer specific combinations of genres. The author uses graphs called radar maps, which show the group separations well. The project IMDB Movie Data Visualization done for movie data set EDA is a notebook on Kaggle that gives conclusions that were not covered in the previous ones. We see, for example, that animation movies have been voted steadily by the Female gender. In contrast, for the Male gender, the ratings decrease as the age increases. In addition, according to this work, sci-fi movies are the most popular ones for the top 1000 voters (movie enthusiasts). The current approach of choosing the top 1000 voters might give better insights as we might assume that those people did not just vote by chance, have watched more movies than the others, hence gave more reliable ratings.

## Hypotheses

We have suggested many hypothesis about the data set’s various columns and row values. Here are all the hypothesis suggested and checked y the project.
1. The majority of the movies have on average run time of 2 hours.
2. Comedy, Drama are the most popular genres.
3. Comedy, Drama and Fantasy are the movie types with the most votes and
satisfaction.
4. The genres mentioned above are also the ones having highest profits.
5. As profit popularity increases, profit increases.
6. The majority of the movies are produced in English.
7. The fact that Johnny Depp is a famous actor makes the movies he is staring in to
receive higher votes.
8. After Syrian Civil War movies about wars increased in count.
9. After 2016 innovation of robot Sophia the movies with keyword “robot” increased in
count.
10. After the establishment of Marvel, 2008, movies with “superhero” keyword
increased in count.

## References

[1] IMDb Movie Data Visualization. (n.d.). Kaggle.com. Retrieved December 4, 2022, from
https://www.kaggle.com/code/soorajsureshbaburaj/imdb-movie-data- visualization/notebook
[2] rahula/eda-movies-dataset - Jovian. (n.d.). Jovian.ai. Retrieved December 4, 2022, from
https://jovian.ai/rahula/eda-movies-dataset
[3] Technical. (2017, December 27). Data analysis from Movie Dataset. Tichung.com.
https://tichung.com/blog/2017/12/data_analysis_from_movie_dataset/

