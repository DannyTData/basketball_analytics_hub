# =====================================================
# Basketball Analytics Hub
# modules/about.R
# About Module 2.0
# =====================================================

about_ui <- function() {
  tagList(
    
    div(
      class = "card",
      h2("ℹ️ About This Hub"),
      p("The Basketball Analytics Hub is a portfolio application built to showcase basketball analytics projects focused on NBA draft evaluation, rookie success prediction, player comparison, team draft grades, and future front-office style tools.")
    ),
    
    fluidRow(
      column(
        6,
        div(
          class = "dark-card",
          h3("About Me"),
          h2("Danny Thompson"),
          p("Basketball Analytics | Predictive Modeling | Sports Data Science"),
          p("My long-term goal is to contribute to an NBA or WNBA front office through basketball operations, analytics, or strategy.")
        )
      ),
      
      column(
        6,
        div(
          class = "dark-card",
          h3("Connect"),
          tags$a("GitHub Profile", href = "https://github.com/DannyTData", target = "_blank"),
          tags$br(), tags$br(),
          tags$a("2026 NBA Draft Value Model", href = "https://github.com/DannyTData/2026-nba-draft-value-model", target = "_blank"),
          tags$br(), tags$br(),
          tags$a("NBA Rookie Success Model", href = "https://github.com/DannyTData/predicting-nba-career-success", target = "_blank"),
          tags$br(), tags$br(),
          tags$a("LinkedIn", href = "https://www.linkedin.com/in/danny-f-thompson/", target = "_blank")
        )
      )
    ),
    
    div(
      class = "card",
      h3("Skills Demonstrated"),
      tags$ul(
        tags$li("R programming"),
        tags$li("Shiny dashboard development"),
        tags$li("Predictive modeling"),
        tags$li("Logistic regression"),
        tags$li("Data cleaning and feature engineering"),
        tags$li("Basketball analytics"),
        tags$li("Data visualization"),
        tags$li("GitHub portfolio development")
      )
    ),
    
    div(
      class = "card",
      h3("Featured Projects"),
      tags$ul(
        tags$li("NBA Rookie Success Model"),
        tags$li("2026 NBA Draft Value Model"),
        tags$li("Basketball Analytics Hub"),
        tags$li("Future NBA Trade Value Model")
      )
    )
  )
}

about_server <- function(input, output, session) {
  # Static page
}