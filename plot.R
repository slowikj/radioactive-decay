library(ggplot2)
library(magrittr)
library(reshape2)
source("formulas.R")

get_plot <- function(start_objects_number, half_life, time_step_number, time_step_length) {
  time_steps <- seq(0, time_step_number * time_step_length, time_step_length)

  theory_objects_number <- get_objects_number_theoretically(start_objects_number, half_life)(time_steps)
  experiment_objects_number <- get_experimental_objects_number(start_objects_number,
                                                               half_life,
                                                               time_step_number,
                                                               time_step_length)
  
  df <- data.frame(
    time = time_steps,
    theory_objects_number = theory_objects_number,
    experiment_objects_number = experiment_objects_number
  ) %>% 
    melt(id.vars=c("time"),
         measure.vars=c("theory_objects_number", "experiment_objects_number"))

  df %>%
    ggplot(aes(x = time, y = value, color=variable)) +
    geom_line() +
    geom_point() +
    scale_color_hue(labels=c("theory", "experiment")) +
    labs(color="type") +
    xlab("time [years]") +
    ylab("available objects") +
    theme_linedraw()
}
