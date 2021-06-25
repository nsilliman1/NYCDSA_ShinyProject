# ---
# title: "NYCDSA Shiny Project"
# author: "Nick Silliman"
# date: "6/21/2021"
# ---

library(shiny)
library(shinydashboard)
library(tidyverse)
library(ggplot2)
# library(GGally)
library(DT)
library(ggridges)
library(scales)
library(RColorBrewer)
library(rsconnect)

# raw data = https://github.com/RosebudAnwuri/TheArtandScienceofData/tree/master/The%20Making%20of%20Great%20Music/data
# https://github.com/kevinschaich/billboard

# setwd(
#   "~/Documents/OneDrive/Documents/School/NYCDSA/Projects/Shiny/NYCDSA_ShinyProject"
# )

music_df <- read_csv("music_df.csv")

music_df = music_df %>% 
  select(
    -c(
    lyrics, id, uri, analysis_url, artist_with_features, image,
    cluster, pos, neg, neu, fog_index, f_k_grade, compound, num_syllables,
    num_lines
    )
  )

music_df = music_df %>% 
  select(
  year_bin, year, artist, Gender, title,
  time_signature, key, mode, duration_ms, num_words, difficult_words,
  num_dupes, flesch_index,everything()
  )

music_df$year_bin =
  factor(music_df$year_bin, levels = c('60s', '70s', '80s', '90s', '00s', '10s'))

# Filter out 50's as there are not that much and my interest is 60s on
music_df = music_df %>% 
  filter(year_bin != '50s') %>%
  mutate(key = as.factor(key))

# Exploratory data analysis
music_df %>% 
  ggplot(
    aes(x = year)) +
    geom_bar()

# ggpairs(
#   music_df %>% select(
#     loudness,
#     acousticness,
#     energy,
#     danceability,
#     speechiness,
#     tempo,
#     liveness,
#     valence
#   )
# )

summary(music_df)

# Exploration
music_df_sum = music_df %>%
  group_by(year_bin) %>%
  summarise(
    Duration = mean(duration_ms) / 1000 / 60,
    Num_Words = mean(num_words),
    Difficult_words = mean(difficult_words),
    Num_Dupes = mean(num_dupes),
    Flesch_Index = mean(flesch_index),
    Danceability = mean(danceability),
    Energy = mean(energy),
    Loudness = mean(loudness),
    Speechiness = mean(speechiness),
    Acousticness = mean(acousticness),
    Instrumentalness = mean(instrumentalness),
    Liveness = mean(liveness),
    Valence = mean(valence),
    Tempo = mean(tempo)
  )