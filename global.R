# =====================================================
# Basketball Analytics Hub
# global.R
# =====================================================

library(shiny)
library(dplyr)
library(readxl)
library(DT)
library(ggplot2)
library(tibble)

draft_scores <- readRDS("data/draft_2026_scores.rds")

team_grades <- read_excel(
  "data/2026_NBA_Draft_Model_Grades.xlsx",
  sheet = "Team_Grades"
)

player_choices <- draft_scores %>%
  arrange(Player) %>%
  pull(Player)

team_choices <- draft_scores %>%
  arrange(Team) %>%
  distinct(Team) %>%
  pull(Team)

total_players <- nrow(draft_scores)
total_teams <- nrow(team_grades)

average_success_score <- round(mean(draft_scores$NBA_Success_Score, na.rm = TRUE), 1)

top_player <- draft_scores %>%
  arrange(desc(NBA_Success_Score)) %>%
  slice(1)

top_steal <- draft_scores %>%
  arrange(desc(Value_Difference)) %>%
  slice(1)

biggest_reach <- draft_scores %>%
  arrange(Value_Difference) %>%
  slice(1)

top10_model <- draft_scores %>%
  arrange(Model_Rank) %>%
  slice(1:10)

percent <- function(x) {
  paste0(round(x * 100, 1), "%")
}

# Source all modules BEFORE ui.R runs
source("modules/home.R")
source("modules/rookie_success.R")
source("modules/draft_value.R")
source("modules/player_lookup.R")
source("modules/player_compare.R")
source("modules/draft_rankings.R")
source("modules/team_grades.R")
source("modules/trade_value.R")
source("modules/about.R")