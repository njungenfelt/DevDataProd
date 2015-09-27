shinyUI(fluidPage(
    tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css")
    ),
    headerPanel("Rock-Paper-Scissors!"),
    sidebarPanel(
        div("Throw:", align = "center", style = "font-size: 19pt"),
        br(),
        actionButton("r", label = "", icon = icon("hand-rock-o",class = "fa-5x", lib = "font-awesome"), width = '100px'),
        br(), br(),
        actionButton("p", label = "", icon = icon("hand-paper-o",class = "fa-5x", lib = "font-awesome"), width = '100px'),
        br(), br(),
        actionButton("s", label = "", icon = icon("hand-scissors-o",class = "fa-5x", lib = "font-awesome"), width = '100px'),
        width = 2,
        style="float:left"
    ),
    mainPanel(
        p('Battle against randomness in a game of ',
          tags$a(href="https://en.wikipedia.org/wiki/Rock-paper-scissors", target="_blank", "Rock-Paper-Scissors"),
          'Pick your throw from the menu to the left and see the results in the table below. The most recent outcome will be shown on the first row.'),
        hr(),
        dataTableOutput('result')
    )
))