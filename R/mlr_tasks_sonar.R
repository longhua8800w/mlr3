#' @title Sonar Classification Task
#'
#' @name mlr_tasks_sonar
#' @format [R6::R6Class] inheriting from [TaskClassif].
#' @include mlr_tasks.R
#'
#' @section Usage:
#' ```
#' mlr_tasks$get("sonar")
#' ```
#'
#' @description
#' A classification task for the [mlbench::Sonar] data set.
#' Positive class is set to "M" (Mine).
mlr_tasks$add("sonar",  function(id = "sonar") {
  b = as_data_backend(load_dataset("Sonar", "mlbench"))
  b$hash = "_mlr33_tasks_sonar_"
  TaskClassif$new(id, b, target = "Class", positive = "M")
})

