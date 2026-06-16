library(shiny)
library(ggplot2)
library(renz)
library(minpack.lm)

source("utilities.R")

server <- function(input, output, session) {
  # Single curve:
  single_data <- eventReactive(input$fit_single, {
    req(input$new_conc, input$new_act)
    data <- parse_input(input$new_conc, input$new_act)
    validate_dataset(data)
    data
  })
  
  
  single_fit <- eventReactive(input$fit_single, {
    req(single_data())
    dir.MM(single_data(), plot = FALSE)
  })
  
  output$single_plot <- renderPlot({
    s_data <- single_data()
    s_fit <- single_fit()
    req(s_data, s_fit)
    
    ggplot(s_data, aes(x = concentration, y = activity)) +
      geom_point(color = "brown2", shape = 18, size = 3) +
      geom_line(data = s_fit$data,
                aes(x = S, y = fitted_v),
                color = "deepskyblue2",
                linewidth = 1) +
      geom_hline(aes(yintercept = s_fit$parameters[2], color = "Vmax"),
                 linetype = "dotdash", linewidth = 0.7) +
      geom_vline(aes(xintercept = s_fit$parameters[1], color = "Km"),
                 linetype = "dashed", linewidth = 0.7) +
      scale_color_manual(values = c(
        "Vmax" = "grey50",
        "Km" = "grey50"
        )) +
      
      labs(
        title = "MM-curve gefit door gemeten datapunten",
        !!!axis_labels(input$single_conc_unit, input$single_act_unit),
        color = "Legenda"
      ) +
      set_theme()
  })
  
  output$single_parameters <- renderText({
    req(single_fit())
    params <- single_fit()$parameters
    
    paste0(
      "Vmax = ", params[2], " ",
      input$single_act_unit,
      " | Km = ", params[1], " ",
      input$single_conc_unit
    )
  })
  
  # Double curve:
  data1 <- eventReactive(input$fit_double, {
    data <- parse_input(input$new_conc1, input$new_act1)
    validate_dataset(data)
    data
  })
  data2 <- eventReactive(input$fit_double, {
    data <- parse_input(input$new_conc2, input$new_act2)
    validate_dataset(data)
    data
  })
  
  fit1 <- eventReactive(input$fit_double, {
    req(data1())
    dir.MM(data1(), plot = FALSE)
  })
  fit2 <- eventReactive(input$fit_double, {
    req(data2())
    dir.MM(data2(), plot = FALSE)
  })
  
  output$double_plot <- renderPlot({
    d_data1 <- data1()
    d_data2 <- data2()
    d_fit1 <- fit1()
    d_fit2 <- fit2()
    req(d_data1, d_data2, d_fit1, d_fit2)
    
    ggplot() +
      geom_point(data = d_data1,
                 aes(x = concentration, y = activity, color = "Dataset 1"),
                 shape = 4, size = 3) +
      geom_line(data = d_fit1$data,
                aes(x = S, y = fitted_v, color = "Fit 1"),
                linewidth = 1) +
      
      geom_point(data = d_data2,
                 aes(x = concentration, y = activity, color = "Dataset 2"),
                 shape = 3, size = 3) +
      geom_line(data = d_fit2$data,
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
        !!!axis_labels(input$double_conc_unit, input$double_act_unit),
        color = "Legenda"
        ) +
      set_theme()
  })
  
  output$double_parameters <- renderText({
    req(fit1(), fit2())
    params1 <- fit1()$parameters
    params2 <- fit2()$parameters
    
    paste0(
      "Dataset 1: \n",
      "Vmax = ", params1[2], " ",
      input$double_act_unit,
      " | Km = ", params1[1], " ",
      input$double_conc_unit,
      "\n\nDataset 2:\n",
      "Vmax = ", params2[2], " ",
      input$double_act_unit,
      " | Km = ", params2[1], " ",
      input$double_conc_unit
      )
  })
  
  # Substrate inhibition:
  data_sub <- eventReactive(input$fit_sub, {
    data <- parse_input(input$new_conc_sub, input$new_act_sub)
    validate_dataset(data)
    data
  })
  
  fit_sub_si <- eventReactive(input$fit_sub, {
    req(data_sub())
    fit_si(data_sub())
  })
  
  output$sub_plot <- renderPlot({
    sub_data <- data_sub()
    sub_si_fit <- fit_sub_si()
    req(sub_data, sub_si_fit)
    
    params <- coef(sub_si_fit)
    
    Vmax <- params["Vmax"]
    Km   <- params["Km"]
    
    pred_df <- sub_data
    pred_df$fitted_v <- predict(sub_si_fit, newdata = pred_df)
    
    ggplot() +
      geom_point(data = sub_data,
                 aes(x = concentration, y = activity, color = "Meetpunten"),
                 shape = 4, size = 3) +
      geom_line(data = pred_df,
                aes(x = concentration, y = fitted_v, color = "Substraat inhibitie"),
                linewidth = 1) +
      geom_hline(aes(yintercept = Vmax, color = "Vmax"),
                 linetype = "dotdash", linewidth = 0.7) +
      geom_vline(aes(xintercept = Km, color = "Km"),
                 linetype = "dashed", linewidth = 0.7) +
      
      scale_color_manual(values = c(
        "Meetpunten" = "deepskyblue4",
        "Substraat inhibitie" = "deeppink",
        "Vmax" = "grey50",
        "Km" = "grey50"
      )) +
      
      labs (
        title = "MM-curve & substraat inhibitie voor gemeten datapunten",
        !!!axis_labels(input$sub_conc_unit, input$sub_act_unit),
        color = "Legenda"
      ) +
      set_theme()
  })
  
  output$sub_parameters <- renderText({
    req(fit_sub_si())
    
    params <- coef(fit_sub_si())
    
    paste0(
      "Vmax = ", round(params["Vmax"], 3), " ",
      input$sub_act_unit,
      " | Km = ", round(params["Km"], 3), " ",
      input$sub_conc_unit
    )
  })
}