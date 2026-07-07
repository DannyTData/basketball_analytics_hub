# =====================================================
# Basketball Analytics Hub
# modules/home.R
# Home dashboard module
# =====================================================

home_ui <- function() {
  tagList(
    fluidRow(
      column(
        3,
        div(
          class = "metric-card",
          div(class = "label", "Draft Class"),
          div(class = "metric", "2026")
        )
      ),
      column(
        3,
        div(
          class = "metric-card",
          div(class = "label", "Players Scored"),
          div(class = "metric", total_players)
        )
      ),
      column(
        3,
        div(
          class = "metric-card",
          div(class = "label", "Average Score"),
          div(class = "metric-green", average_success_score)
        )
      ),
      column(
        3,
        div(
          class = "metric-card",
          div(class = "label", "Teams Graded"),
          div(class = "metric", total_teams)
        )
      )
    ),
    
    fluidRow(
      column(
        4,
        div(
          class = "dark-card",
          h3("Top Model Prospect"),
          h2(top_player$Player),
          h4(paste("Score:", top_player$NBA_Success_Score)),
          p(paste("Team:", top_player$Team)),
          p(paste("Draft Pick:", top_player$Draft_Rank))
        )
      ),
      column(
        4,
        div(
          class = "dark-card",
          h3("Biggest Model Steal"),
          h2(top_steal$Player),
          h4(paste("Draft Value:", top_steal$Value_Difference)),
          p(paste("Team:", top_steal$Team)),
          p(paste("Draft Pick:", top_steal$Draft_Rank))
        )
      ),
      column(
        4,
        div(
          class = "dark-card",
          h3("Biggest Model Reach"),
          h2(biggest_reach$Player),
          h4(paste("Draft Value:", biggest_reach$Value_Difference)),
          p(paste("Team:", biggest_reach$Team)),
          p(paste("Draft Pick:", biggest_reach$Draft_Rank))
        )
      )
    ),
    
    div(
      class = "card",
      h2("Basketball Analytics Portfolio"),
      p("This hub brings together basketball analytics projects focused on rookie success prediction, draft value, player comparison, team draft grades, and future front-office decision tools."),
      tags$ul(
        tags$li("NBA Rookie Success Model"),
        tags$li("2026 NBA Draft Value Model"),
        tags$li("Player lookup and comparison tools"),
        tags$li("Team draft grades"),
        tags$li("Future trade value modeling")
      )
    ),
    
    div(
      class = "card",
      h2("Featured 2026 Draft Rankings"),
      DTOutput("home_top10")
    )
  )
}

home_server <- function(input, output, session) {
  output$home_top10 <- renderDT({
    top10_model %>%
      select(
        Model_Rank,
        Draft_Rank,
        Player,
        Team,
        NBA_Success_Score,
        probability,
        Value_Difference
      ) %>%
      mutate(
        probability = percent(probability)
      )
  })
}