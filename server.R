# =====================================================
# Basketball Analytics Hub
# server.R
# Connects app server logic
# =====================================================

hub_server <- function(input, output, session) {
  
  # Home dashboard
  home_server(input, output, session)
  
  # Project pages
  rookie_success_server(input, output, session)
  draft_value_server(input, output, session)
  
  # Player tools
  player_lookup_server(input, output, session)
  player_compare_server(input, output, session)
  
  # Draft / team tools
  draft_rankings_server(input, output, session)
  team_grades_server(input, output, session)
  
  # Future tools
  trade_value_server(input, output, session)
  
  # About page
  about_server(input, output, session)
  
}