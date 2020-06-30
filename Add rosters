# Anyone who uses @nflfastR may find this useful: I built a comprehensive list of player positions for the 2011-2019 seasons. 

## load libraries
library(nflfastR)
library(tidyverse)
library(dplyr)

## Upload roster file
reg_season_rosters <- read_csv(url("https://raw.githubusercontent.com/samhoppen/NFL_rosters/master/reg_season_rosters_2011_2019.csv"))

## Upload play-by-play data for seasons 2011-2019 (from Ben Baldwin nflfastR Beginner's Guide)
seasons <- 2011:2019
pbp <- purrr::map_df(seasons, function(x) {
  readRDS(
    url(
      glue::glue("https://raw.githubusercontent.com/guga31bb/nflfastR-data/master/data/play_by_play_{x}.rds")
    )
  )
})

## Add position and full player name for passers, receivers, and rushers
pbp_with_positions <- pbp %>% 
  left_join(reg_season_rosters, by = c("passer_player_id" = "player_id")) %>% 
  rename(
    passer_full_name = full_player_name,
    passer_position = position
  ) %>% 
  select(-c('player', 'season', 'posteam', 'season_type', 'gsis_id')) %>% 
  left_join(reg_season_rosters, by =c("receiver_player_id" = "player_id")) %>% 
  rename(
    receiver_full_name = full_player_name,
    receiver_position = position
  ) %>% 
  select(-c('player', 'season', 'posteam', 'season_type', 'gsis_id')) %>% 
  left_join(reg_season_rosters, by = c("rusher_player_id" = "player_id")) %>% 
  rename(
    rusher_full_name = full_player_name,
    rusher_position = position
  ) %>% 
  select(-c('player', 'season', 'posteam', 'season_type', 'gsis_id'))
