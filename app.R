# =====================================================
# Basketball Analytics Hub
# app.R
# Main application launcher
# =====================================================

source("global.R")

# Source modules first
source("modules/home.R")
source("modules/rookie_success.R")
source("modules/draft_value.R")
source("modules/player_lookup.R")
source("modules/player_compare.R")
source("modules/draft_rankings.R")
source("modules/team_grades.R")
source("modules/trade_value.R")
source("modules/about.R")

# Then source UI/server
source("ui.R")
source("server.R")

shinyApp(
  ui = hub_ui(),
  server = hub_server
)