library(shiny)
set.seed(as.integer(Sys.time()))
options(stringsAsFactors = FALSE)
rps <- c("Rock", "Paper", "Scissors")

shinyServer(
    function(input, output, session) {
        computerThrow <- reactiveValues()
        playerThrow <- reactiveValues()
        winner <- reactiveValues()
        results <- reactiveValues()
        results$df <- data.frame(You = character(0), Computer = character(0), Winner = character(0), Standings = character(0))
        standings <- reactiveValues()
        standings$current <- c(p = 0, x = 0, c = 0)
        observeEvent(input$r, {
            computerThrow$id <- throw()
            computerThrow$label <- rps[computerThrow$id]
            playerThrow$id <- 1
            playerThrow$label <- rps[playerThrow$id]
        })
        observeEvent(input$p, {
            computerThrow$id <- throw()
            computerThrow$label <- rps[computerThrow$id]
            playerThrow$id <- 2
            playerThrow$label <- rps[playerThrow$id]
        })
        observeEvent(input$s, {
            computerThrow$id <- throw()
            computerThrow$label <- rps[computerThrow$id]
            playerThrow$id <- 3
            playerThrow$label <- rps[playerThrow$id]
        })
        newEntry <- observe({
            if ((input$r > 0) || (input$p > 0) || (input$s > 0)) {
                winner$id <- (playerThrow$id - computerThrow$id) %% 3
                if (winner$id == 0) {
                    isolate(standings$current <- standings$current + c(0, 1, 0))
                    winner$label <- "Tie"
                } else if (winner$id == 1) {
                    isolate(standings$current <- standings$current + c(1, 0, 0))
                    winner$label <- "You!"
                } else if (winner$id == 2) {
                    isolate(standings$current <- standings$current + c(0, 0, 1))
                    winner$label <- "Computer!"
                } else {
                    winner$label <- ""
                }
                newLine <- data.frame(
                    You = playerThrow$label,
                    Computer = computerThrow$label,
                    Winner = winner$label,
                    Standings = paste(standings$current, collapse = "-")
                )
                isolate(results$df <- rbind(newLine, results$df))
            }
        })
        output$result <- renderDataTable({results$df}, options = list(searching = FALSE,
                                                                      ordering = FALSE,
                                                                      lengthMenu = list(c(5, 10, -1), c('5', '10', 'All')),
                                                                      pageLength = 5))
        
        throw <- function(history) {
            id <- sample(1:3,1)
            return(id)
        }
    }
)