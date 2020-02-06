get_objects_number_theoretically <- function(start_objects_number, half_life) {
  function(time_elapsed) {
    start_objects_number * (2 ^ (-time_elapsed / half_life))
  }
}

get_life_probability <- function(half_life) {
  function(time_elapsed) {
    2 ^ (-time_elapsed / half_life)
  }
}

get_experimental_objects_number <- function(start_objects_number, half_life, time_step_number, time_step_length) {
  life_probability_fun <- get_life_probability(half_life)
  current_objects_number <- start_objects_number
  current_time <- 0
  res <- rep(NA, time_step_number)
  time_elapsed_seq <- seq(0, time_step_number * time_step_length, time_step_length)
  for (i in 1:length(time_elapsed_seq)) {
    current_time <- time_elapsed_seq[i]
    life_probability <- life_probability_fun(current_time)
    current_objects_number <- sum(runif(current_objects_number, 0, 1) < life_probability)
    res[i] <- current_objects_number
  }
  res
}