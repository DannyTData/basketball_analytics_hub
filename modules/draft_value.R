# =====================================================
# Basketball Analytics Hub
# modules/draft_value.R
# 2026 Draft Value Model module
# =====================================================

draft_value_ui <- function() {
  tagList(
    div(
      class = "card",
      h2("📈 2026 NBA Draft Value Model"),
      p("This model evaluates 2026 NBA Draft prospects using pre-draft production, advanced efficiency, age, and physical profile."),
      p("Draft position was removed from the prediction model to better identify value independent of draft order.")
    ),
    
    fluidRow(
      column(
        6,
        div(
          class = "card",
          h4("Top 15 NBA Success Scores"),
          img(src = "top_15_success_scores.png", width = "100%")
        )
      ),
      column(
        6,
        div(
          class = "card",
          h4("Biggest Draft Steals"),
          img(src = "biggest_draft_steals.png", width = "100%")
        )
      )
    ),
    
    fluidRow(
      column(
        6,
        div(
          class = "card",
          h4("Biggest Draft Reaches"),
          img(src = "biggest_draft_reaches.png", width = "100%")
        )
      ),
      column(
        6,
        div(
          class = "card",
          h4("Draft Pick vs Success Score"),
          img(src = "draft_pick_vs_success_score.png", width = "100%")
        )
      )
    )
  )
}

draft_value_server <- function(input, output, session) {
  # Static chart page
}