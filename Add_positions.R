## Load libraries
library(tidyverse)
library(dplyr)
library(nflfastR)

## Upload roster file
nfl_positions <- read_csv(url("https://raw.githubusercontent.com/samhoppen/NFL_rosters/master/nfl_positions_2011_2020.csv"))

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
  left_join(nfl_positions, by = c("passer_id" = "player_id")) %>% 
  rename(
    passer_full_name = full_player_name,
    passer_position = position
  ) %>% 
  left_join(nfl_positions, by = c("receiver_id" = "player_id")) %>% 
  rename(
    receiver_full_name = full_player_name,
    receiver_position = position
  ) %>% 
  left_join(nfl_positions, by = c("rusher_id" = "player_id")) %>% 
  rename(
    rusher_full_name = full_player_name,
    rusher_position = position) %>% 
  select(-c('player.x', 'player.y', 'player'))
