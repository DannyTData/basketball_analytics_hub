# =====================================================
# Basketball Analytics Hub
# modules/team_grades.R
# Team Grades 2.0
# =====================================================

team_grades_ui <- function() {
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "selected_team",
        "Select Team:",
        choices = team_choices
      )
    ),
    
    mainPanel(
      uiOutput("team_summary"),
      uiOutput("team_picks"),
      div(
        class = "card",
        h2("All Team Grades"),
        DTOutput("team_grades")
      )
    )
  )
}

team_grades_server <- function(input, output, session) {
  
  selected_team_data <- reactive({
    draft_scores %>%
      filter(Team == input$selected_team) %>%
      arrange(Model_Rank)
  })
  
  output$team_summary <- renderUI({
    team_data <- selected_team_data()
    
    avg_score <- round(mean(team_data$NBA_Success_Score, na.rm = TRUE), 1)
    total_value <- round(sum(team_data$Value_Difference, na.rm = TRUE), 1)
    best_pick <- team_data %>%
      arrange(desc(NBA_Success_Score)) %>%
      slice(1)
    
    fluidRow(
      column(3, div(class = "metric-card", div(class = "label", "Team"), div(class = "metric", input$selected_team))),
      column(3, div(class = "metric-card", div(class = "label", "Picks Scored"), div(class = "metric", nrow(team_data)))),
      column(3, div(class = "metric-card", div(class = "label", "Avg Score"), div(class = "metric-green", avg_score))),
      column(3, div(class = "metric-card", div(class = "label", "Total Value"), div(class = ifelse(total_value >= 0, "metric-green", "metric-red"), total_value))),
      
      column(
        12,
        div(
          class = "dark-card",
          h2("Best Model Pick"),
          h3(best_pick$Player),
          h4(paste("Success Score:", round(best_pick$NBA_Success_Score, 1))),
          p(paste("Draft Pick:", best_pick$Draft_Rank, "| Model Rank:", best_pick$Model_Rank))
        )
      )
    )
  })
  
  output$team_picks <- renderUI({
    team_data <- selected_team_data()
    
    div(
      class = "card",
      h2("Team Picks"),
      tags$table(
        class = "custom-table",
        tags$tr(
          tags$th("Player"),
          tags$th("Draft Pick"),
          tags$th("Model Rank"),
          tags$th("Success Score"),
          tags$th("Probability"),
          tags$th("Draft Value")
        ),
        lapply(1:nrow(team_data), function(i) {
          p <- team_data[i, ]
          
          tags$tr(
            tags$td(p$Player),
            tags$td(p$Draft_Rank),
            tags$td(p$Model_Rank),
            tags$td(round(p$NBA_Success_Score, 1)),
            tags$td(percent(p$probability)),
            tags$td(round(p$Value_Difference, 1))
          )
        })
      )
    )
  })
  
  output$team_grades <- renderDT({
    team_grades
  },
  options = list(
    pageLength = 15,
    scrollX = TRUE
  ))
}