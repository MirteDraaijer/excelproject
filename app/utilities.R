library(ggplot2)

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

fit_si <- function(data_frame) {
  nlsLM(
    activity ~ (Vmax * concentration) / (Km + concentration * (1 + concentration / Ki)),
    data = data_frame,
    start = list(Vmax = max(data_frame$activity), 
                 Km = median(data_frame$concentration), 
                 Ki = max(data_frame$concentration)),
    control = nls.lm.control(maxiter = 500)
  )
}

validate_dataset <- function(data) {
  validate(
    need(length(data$concentration) > 0 && length(data$activity) > 0,
         "Voer waarden in gescheiden door komma's."),
    need(!any(is.na(data$concentration)) && !any(is.na(data$activity)),
         "Gebruik alleen numerieke waarden."),
    need(length(data$concentration) == length(data$activity),
         "Aantal concentraties en activiteiten moet gelijk zijn.")
  )
}

set_theme <- function(){
  theme_set(
    theme_minimal() +
      theme(
        plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
        axis.title = element_text(face = "bold")
      )
  )
}

axis_labels <- function(x_unit, y_unit){
  list(
    x = paste0("Concentratie (", x_unit, ")"),
    y = paste0("Activiteit (", y_unit, ")")
  )
}