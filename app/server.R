library(shiny)
library(ggplot2)
library(renz)

# Helper function:
parse_input <- function(conc_input, act_input) {
  conc <- as.numeric(unlist(strsplit(conc_input, ",")))
  act <- as.numeric(unlist(strsplit(act_input, ",")))
  
  if (length(conc) != length(act)) {
    return(NULL)
  }
  data.frame(
    concentration = conc,
    activity = act
  )
}

server <- function(input, output, session) {
  # Single curve:
  single_data <- eventReactive(input$fit_single, {
    req(input$new_conc, input$new_act)
    data <- parse_input(input$new_conc, input$new_act)
    
    validate(
      need(length(data$concentration) > 0 && length(data$activity) > 0,
           "Voer waarden in gescheiden door komma's."),
      need(!any(is.na(data$concentration)) && !any(is.na(data$activity)),
           "Gebruik alleen numerieke waarden."),
      need(length(data$concentration) == length(data$activity),
           "Aantal concentraties en activiteiten moet gelijk zijn.")
    )
    data
  })
  
  single_fit <- eventReactive(input$fit_single, {
    req(single_data())
    dir.MM(single_data(), plot = FALSE)
  })
  
  output$single_plot <- renderPlot({
    req(single_data(), single_fit())
    
    ggplot(single_data(), aes(x = concentration, y = activity)) +
      geom_point(color = "brown2", shape = 18, size = 3) +
      geom_line(data = single_fit()$data,
                aes(x = S, y = fitted_v),
                color = "deepskyblue2",
                linewidth = 1) +
      labs(
        title = "MM-curve gefit door gemeten datapunten",
        x = paste0("Concentratie (", input$single_conc_unit, ")"),
        y = paste0("Activiteit (", input$single_act_unit, ")")
      ) +
      theme_minimal()
  })
  
  # Double curve:
  data1 <- eventReactive(input$fit_double, {
    parse_input(input$new_conc1, input$new_act1)
  })
  data2 <- eventReactive(input$fit_double, {
    parse_input(input$new_conc2, input$new_act2)
  })
  
  fit1 <- eventReactive(input$fit_double, {
    dir.MM(data1(), plot = FALSE)
  })
  fit2 <- eventReactive(input$fit_double, {
    dir.MM(data2(), plot = FALSE)
  })
  
  output$double_plot <- renderPlot({
    ggplot() +
      geom_point(data = data1(),
                 aes(x = concentration, y = activity, color = "Dataset 1"),
                 shape = 4, size = 3) +
      geom_line(data = fit1()$data,
                aes(x = S, y = fitted_v, color = "Fit 1"),
                linewidth = 1) +
      
      geom_point(data = data2(),
                 aes(x = concentration, y = activity, color = "Dataset 2"),
                 shape = 3, size = 3) +
      geom_line(data = fit2()$data,
                aes(x = S, y = fitted_v, color = "Fit 2"),
                linewidth = 1) +
      
      scale_color_manual(values = c(
        "Dataset 1" = "deepskyblue4",
        "Fit 1" = "deepskyblue",
        "Dataset 2" = "deeppink4",
        "Fit 2" = "deeppink"
        )) +
      
      labs (
        title = "MM-curve gefit door gemeten datapunten",
        x = paste0("Concentratie (", input$double_conc_unit, ")"),
        y = paste0("Activiteit (", input$double_act_unit, ")"),
        color = "Legenda"
        ) +
      
      theme_minimal() +
      theme(
        plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
        axis.title = element_text(face = "bold")
        )
  })
}