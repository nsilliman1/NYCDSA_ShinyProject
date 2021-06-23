# ---
# title: "NYCDSA Shiny Project"
# author: "Nick Silliman"
# date: "6/21/2021"
# ---

library(shiny)
library(shinydashboard)
library(tidyverse)
library(ggplot2)
library(GGally)
library(DT)
library(ggridges)

# raw data = https://github.com/RosebudAnwuri/TheArtandScienceofData/tree/master/The%20Making%20of%20Great%20Music/data
# https://github.com/kevinschaich/billboard

setwd("~/Documents/OneDrive/Documents/School/NYCDSA/Projects/Shiny/NYCDSA_ShinyProject")
music_df <- read_csv("music_df.csv")
music_df = music_df %>% select(-c(lyrics, id, uri, analysis_url, artist_with_features, image, cluster,
                                  pos,neg,neu,fog_index,f_k_grade,compound,
                                  num_syllables,num_lines))
### you should sort the fields for the dataset tab when finished and also exclude the ones you aren't using

# Filter out 50's as there are not that much and my interest is 60s on
music_df = music_df %>% filter(year_bin != '50s') %>% 
  mutate(key = as.character(key))

# Exploratory data analysis
music_df %>% ggplot(
  aes(x = year)) +
  geom_bar()

ggpairs(music_df %>% select(loudness, acousticness,
                            energy, danceability, speechiness, tempo,
                            liveness, valence))

summary(music_df)

# Analysis
music_df %>% group_by(year) %>% summarise(MeanDurationMin= mean(duration_ms/1000/60)) %>%
  ggplot(
    aes(x = year, y = MeanDurationMin)) +
    geom_line(color = 'blue') +
    theme_bw() +
    ggtitle("Average Duration of Songs by Year (min)") + 
    xlab("Year") +
    ylab("Minutes")

music_df %>%
  ggplot(aes(x = as.integer(key), y = year_bin, fill = year_bin)) +
  geom_density_ridges() +
  theme_bw() +
  ggtitle("Density of Keys by Decade") + 
  xlab("Key") +
  ylab("Density")

#probably get these on a dual axis
music_df %>% group_by(year) %>% summarise(MeanLoudness = mean(loudness)) %>%
  ggplot(aes(x = year)) +
  geom_line(aes(y = MeanLoudness), color = 'blue') +
  theme_bw() +
  ggtitle("Average Loudness by Year (db)") + 
  xlab("Year") +
  ylab("Decibals")
music_df %>% group_by(year) %>% summarise(MeanAcoustic = mean(acousticness)) %>%
  ggplot(aes(x = year)) +
  geom_line(aes(y = MeanAcoustic), color = 'red') +
  theme_bw() +
  ggtitle("Average Acousticness by Year") + 
  xlab("Year") +
  ylab("Acousticness")

music_df %>% group_by(year, Gender) %>% summarise(n = sum(n())) %>% 
  mutate(Percentage = n/sum(n)) %>% 
  ggplot(
    aes(x = year, y = Percentage, fill = Gender)) +
    geom_bar(stat = 'identity') +
    theme_bw() +
    ggtitle("Groups by Type by Year") + 
    xlab("Year") +
    ylab("Percetage")
  


