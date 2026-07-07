# =====================================================
# Basketball Analytics Hub
# ui.R
# =====================================================

hub_ui <- function() {
  fluidPage(
    tags$head(
      tags$style(HTML("
        body {
          background: #071A2F;
          font-family: Arial, sans-serif;
          color: #EAF3FF;
        }

        .app-title {
          background: linear-gradient(135deg, #0B1F3A, #1D428A);
          padding: 30px;
          border-radius: 18px;
          margin-bottom: 25px;
          box-shadow: 0 4px 18px rgba(0,0,0,.35);
        }

        .nav-tabs > li > a {
          color: #EAF3FF;
          background-color: #0B1F3A;
          border: none;
          margin-right: 5px;
          border-radius: 10px 10px 0 0;
          font-weight: bold;
        }

        .nav-tabs > li.active > a,
        .nav-tabs > li.active > a:focus,
        .nav-tabs > li.active > a:hover {
          color: white;
          background-color: #1D428A;
          border: none;
        }

        .card {
          background: #FFFFFF;
          color: #0B1F3A;
          padding: 24px;
          border-radius: 18px;
          box-shadow: 0 4px 16px rgba(0,0,0,.22);
          margin-bottom: 24px;
        }

        .dark-card {
          background: #0B1F3A;
          color: white;
          padding: 24px;
          border-radius: 18px;
          box-shadow: 0 4px 16px rgba(0,0,0,.25);
          margin-bottom: 24px;
        }

        .metric-card {
          background: #FFFFFF;
          color: #0B1F3A;
          padding: 22px;
          border-radius: 18px;
          text-align: center;
          box-shadow: 0 4px 14px rgba(0,0,0,.20);
          margin-bottom: 20px;
        }

        .metric {
          font-size: 36px;
          font-weight: bold;
          color: #1D428A;
        }

        .metric-green {
          font-size: 36px;
          font-weight: bold;
          color: #2E8B57;
        }

        .metric-red {
          font-size: 36px;
          font-weight: bold;
          color: #C8102E;
        }

        .label {
          color: #666;
          text-transform: uppercase;
          font-size: 13px;
          font-weight: bold;
          letter-spacing: .5px;
        }

        .player-title {
          font-size: 36px;
          font-weight: bold;
          color: #0B1F3A;
        }

        .subtle {
          color: #667;
          font-size: 16px;
        }

        .note-box {
          background: #EAF3FF;
          border-left: 5px solid #1D428A;
          color: #0B1F3A;
          padding: 18px;
          border-radius: 12px;
          margin-top: 20px;
          font-size: 16px;
        }

        table.custom-table {
          width: 100%;
          border-collapse: collapse;
          margin-top: 15px;
        }

        table.custom-table th {
          background: #0B1F3A;
          color: white;
          text-align: center;
          padding: 12px;
        }

        table.custom-table td {
          text-align: center;
          padding: 12px;
          border-bottom: 1px solid #ddd;
        }

        img {
          border-radius: 14px;
        }

        a {
          color: #89C2FF;
          font-weight: bold;
        }
      "))
    ),
    
    div(
      class = "app-title",
      h1("🏀 Basketball Analytics Hub"),
      h4("NBA Draft Value • Rookie Success • Player Evaluation • Front Office Tools")
    ),
    
    tabsetPanel(
      tabPanel("Home", home_ui()),
      tabPanel("Rookie Success Model", rookie_success_ui()),
      tabPanel("2026 Draft Value", draft_value_ui()),
      tabPanel("Player Lookup", player_lookup_ui()),
      tabPanel("Player Comparison", player_compare_ui()),
      tabPanel("Draft Rankings", draft_rankings_ui()),
      tabPanel("Team Grades", team_grades_ui()),
      tabPanel("Trade Value", trade_value_ui()),
      tabPanel("About", about_ui())
    )
  )
}