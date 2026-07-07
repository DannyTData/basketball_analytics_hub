# =====================================================
# Basketball Analytics Hub
# modules/player_compare.R
# Player Comparison 3.0
# =====================================================

player_compare_ui <- function() {
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput(
        "player1",
        "Player 1",
        choices = player_choices
      ),
      
      selectInput(
        "player2",
        "Player 2",
        choices = player_choices,
        selected = player_choices[2]
      )
      
    ),
    
    mainPanel(
      
      uiOutput("comparison_summary"),
      
      uiOutput("comparison_cards"),
      
      uiOutput("comparison_bars")
      
    )
    
  )
  
}

player_compare_server <- function(input, output, session) {
  
  selected_players <- reactive({
    
    draft_scores %>%
      filter(Player %in% c(input$player1, input$player2)) %>%
      arrange(match(Player, c(input$player1, input$player2)))
    
  })
  
  output$comparison_summary <- renderUI({
    
    p <- selected_players()
    
    winner <- p %>%
      arrange(desc(NBA_Success_Score)) %>%
      slice(1)
    
    div(
      class = "dark-card",
      h2("🏆 Model Preference"),
      h1(winner$Player),
      h3(paste("Success Score:", round(winner$NBA_Success_Score, 1))),
      p(paste("Model Rank:", winner$Model_Rank, "| Draft Pick:", winner$Draft_Rank))
    )
    
  })
  
  output$comparison_cards <- renderUI({
    
    p <- selected_players()
    
    fluidRow(
      
      lapply(1:nrow(p), function(i) {
        
        player <- p[i, ]
        
        column(
          6,
          div(
            class = "card",
            h2(player$Player),
            h4(paste(player$Team, "| Draft Pick:", player$Draft_Rank)),
            
            fluidRow(
              column(
                6,
                div(
                  class = "metric-card",
                  div(class = "label", "Success Score"),
                  div(class = "metric-green", round(player$NBA_Success_Score, 1))
                )
              ),
              column(
                6,
                div(
                  class = "metric-card",
                  div(class = "label", "Draft Value"),
                  div(
                    class = ifelse(player$Value_Difference >= 0, "metric-green", "metric-red"),
                    round(player$Value_Difference, 1)
                  )
                )
              )
            )
          )
        )
        
      })
      
    )
    
  })
  
  output$comparison_bars <- renderUI({
    
    p <- selected_players()
    
    p1 <- p[1, ]
    p2 <- p[2, ]
    
    metric_rows <- tibble::tibble(
      Metric = c(
        "NBA Success Score",
        "PPG",
        "RPG",
        "APG",
        "SPG",
        "BPG",
        "AST/TO",
        "TS%"
      ),
      Player1_Value = c(
        p1$NBA_Success_Score,
        p1$PPG,
        p1$RPG,
        p1$APG,
        p1$SPG,
        p1$BPG,
        p1$AST_TO,
        p1$college_ts_pct * 100
      ),
      Player2_Value = c(
        p2$NBA_Success_Score,
        p2$PPG,
        p2$RPG,
        p2$APG,
        p2$SPG,
        p2$BPG,
        p2$AST_TO,
        p2$college_ts_pct * 100
      )
    )
    
    tagList(
      
      div(
        class = "card",
        h2("Head-to-Head Metric Comparison"),
        p("Longer bars show the player with the stronger value in each category."),
        
        lapply(1:nrow(metric_rows), function(i) {
          
          row <- metric_rows[i, ]
          
          max_value <- max(row$Player1_Value, row$Player2_Value, na.rm = TRUE)
          
          p1_width <- ifelse(max_value == 0, 0, row$Player1_Value / max_value * 100)
          p2_width <- ifelse(max_value == 0, 0, row$Player2_Value / max_value * 100)
          
          p1_wins <- row$Player1_Value >= row$Player2_Value
          p2_wins <- row$Player2_Value > row$Player1_Value
          
          div(
            style = "margin-bottom: 26px;",
            
            h4(row$Metric),
            
            fluidRow(
              column(
                2,
                strong(p1$Player),
                br(),
                span(round(row$Player1_Value, 1))
              ),
              column(
                8,
                div(
                  style = "background:#E6EAF0; border-radius:999px; height:22px; margin-bottom:8px;",
                  div(
                    style = paste0(
                      "width:", p1_width, "%;",
                      "background:", ifelse(p1_wins, "#2E8B57", "#1D428A"), ";",
                      "height:22px; border-radius:999px;"
                    )
                  )
                ),
                div(
                  style = "background:#E6EAF0; border-radius:999px; height:22px;",
                  div(
                    style = paste0(
                      "width:", p2_width, "%;",
                      "background:", ifelse(p2_wins, "#2E8B57", "#1D428A"), ";",
                      "height:22px; border-radius:999px;"
                    )
                  )
                )
              ),
              column(
                2,
                strong(p2$Player),
                br(),
                span(round(row$Player2_Value, 1))
              )
            )
          )
          
        })
      )
    )
    
  })
  
}