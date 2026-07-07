# =====================================================
# Basketball Analytics Hub
# modules/rookie_success.R
# Rookie Success Model module
# =====================================================

rookie_success_ui <- function() {
  tagList(
    div(
      class = "card",
      h2("🏀 NBA Rookie Success Model"),
      p("This companion project predicts long-term NBA career success using historical draft classes from 2012–2020."),
      tags$ul(
        tags$li("Trained on 382 NBA draft selections"),
        tags$li("Uses pre-draft college production, physical measurements, and efficiency metrics"),
        tags$li("Includes a deployed Shiny dashboard"),
        tags$li("Serves as the historical foundation for the 2026 Draft Value Model")
      )
    ),
    
    fluidRow(
      column(
        6,
        div(
          class = "dark-card",
          h3("GitHub Repository"),
          p("View the model code, README, charts, and historical workflow."),
          tags$a(
            "Open GitHub Repository",
            href = "https://github.com/DannyTData/predicting-nba-career-success",
            target = "_blank"
          )
        )
      ),
      column(
        6,
        div(
          class = "dark-card",
          h3("Live Dashboard"),
          p("Open the deployed Rookie Success Shiny application."),
          tags$a(
            "Open Live Dashboard",
            href = "https://yfazp7-danny-thompson.shinyapps.io/nba-rookie-success-model/",
            target = "_blank"
          )
        )
      )
    )
  )
}

rookie_success_server <- function(input, output, session) {
  # Static page for now
}