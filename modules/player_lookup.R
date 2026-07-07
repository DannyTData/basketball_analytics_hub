# =====================================================
# Basketball Analytics Hub
# modules/player_lookup.R
# Player Lookup 2.0 module
# =====================================================

player_lookup_ui <- function() {
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "player",
        "Search Player:",
        choices = player_choices
      )
    ),
    mainPanel(
      uiOutput("player_card")
    )
  )
}

player_lookup_server <- function(input, output, session) {
  
  output$player_card <- renderUI({
    p <- draft_scores %>%
      filter(Player == input$player) %>%
      slice(1)
    
    value_text <- ifelse(
      p$Value_Difference >= 0,
      paste("Model liked him", p$Value_Difference, "spots higher than draft slot"),
      paste("Model ranked him", abs(p$Value_Difference), "spots lower than draft slot")
    )
    
    model_note <- paste0(
      p$Player,
      " posted a model success score of ",
      p$NBA_Success_Score,
      " with a projected success probability of ",
      round(p$probability * 100, 1),
      "%. His profile is driven by college production, efficiency, physical measurements, age, and assist-to-turnover performance."
    )
    
    tagList(
      div(
        class = "card",
        div(class = "player-title", p$Player),
        div(class = "subtle", paste(p$Team, "| Draft Pick:", p$Draft_Rank)),
        div(class = "note-box", value_text)
      ),
      
      fluidRow(
        column(3, div(class = "metric-card", div(class = "label", "Model Rank"), div(class = "metric", p$Model_Rank))),
        column(3, div(class = "metric-card", div(class = "label", "Success Score"), div(class = "metric-green", p$NBA_Success_Score))),
        column(3, div(class = "metric-card", div(class = "label", "Probability"), div(class = "metric", percent(p$probability)))),
        column(3, div(class = "metric-card", div(class = "label", "Draft Value"), div(class = ifelse(p$Value_Difference >= 0, "metric-green", "metric-red"), p$Value_Difference)))
      ),
      
      div(
        class = "card",
        h3("Physical Profile"),
        tags$table(
          class = "custom-table",
          tags$tr(tags$th("Age"), tags$th("Height"), tags$th("Weight")),
          tags$tr(tags$td(round(p$draft_age, 1)), tags$td(p$height_inches), tags$td(p$weight))
        )
      ),
      
      div(
        class = "card",
        h3("College Production"),
        tags$table(
          class = "custom-table",
          tags$tr(tags$th("PPG"), tags$th("RPG"), tags$th("APG"), tags$th("SPG"), tags$th("BPG"), tags$th("AST/TO"), tags$th("TS%")),
          tags$tr(
            tags$td(round(p$PPG, 1)),
            tags$td(round(p$RPG, 1)),
            tags$td(round(p$APG, 1)),
            tags$td(round(p$SPG, 1)),
            tags$td(round(p$BPG, 1)),
            tags$td(round(p$AST_TO, 2)),
            tags$td(percent(p$college_ts_pct))
          )
        )
      ),
      
      div(class = "note-box", strong("Model Summary: "), model_note)
    )
  })
}