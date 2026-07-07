# =====================================================
# Basketball Analytics Hub
# modules/draft_rankings.R
# Draft Rankings 2.0
# =====================================================

draft_rankings_ui <- function() {
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "rank_team",
        "Filter by Team:",
        choices = c("All Teams", team_choices)
      ),
      
      sliderInput(
        "min_score",
        "Minimum Success Score:",
        min = 0,
        max = 100,
        value = 0,
        step = 5
      ),
      
      selectInput(
        "value_filter",
        "Draft Value:",
        choices = c("All", "Positive Value", "Negative Value")
      )
    ),
    
    mainPanel(
      div(
        class = "card",
        h2("📋 Draft Rankings"),
        p("Filter the 2026 draft class by team, success score, and model draft value."),
        DTOutput("rankings")
      )
    )
  )
}

draft_rankings_server <- function(input, output, session) {
  
  filtered_rankings <- reactive({
    data <- draft_scores
    
    if (input$rank_team != "All Teams") {
      data <- data %>%
        filter(Team == input$rank_team)
    }
    
    data <- data %>%
      filter(NBA_Success_Score >= input$min_score)
    
    if (input$value_filter == "Positive Value") {
      data <- data %>%
        filter(Value_Difference > 0)
    }
    
    if (input$value_filter == "Negative Value") {
      data <- data %>%
        filter(Value_Difference < 0)
    }
    
    data
  })
  
  output$rankings <- renderDT({
    filtered_rankings() %>%
      select(
        Model_Rank,
        Draft_Rank,
        Player,
        Team,
        NBA_Success_Score,
        probability,
        Value_Difference,
        PPG,
        RPG,
        APG,
        AST_TO,
        college_ts_pct
      ) %>%
      mutate(
        NBA_Success_Score = round(NBA_Success_Score, 1),
        probability = percent(probability),
        Value_Difference = round(Value_Difference, 1),
        PPG = round(PPG, 1),
        RPG = round(RPG, 1),
        APG = round(APG, 1),
        AST_TO = round(AST_TO, 1),
        college_ts_pct = percent(college_ts_pct)
      ) %>%
      rename(
        `AST/TO` = AST_TO,
        `TS%` = college_ts_pct
      ) %>%
      arrange(Model_Rank)
  },
  options = list(
    pageLength = 15,
    scrollX = TRUE
  ))
}