#' @title Accuracy Classification Measure
#'
#' @name mlr_measures_classif_acc
#' @format [R6::R6Class()] inheriting from [MeasureClassif].
#'
#' @description
#' Calls [Metrics::accuracy].
#'
#' @export
#' @include MeasureClassif.R
MeasureClassifACC = R6Class("MeasureClassifACC",
  inherit = MeasureClassif,
  public = list(
    initialize = function() {
      super$initialize(
        id = "acc",
        range = 0:1,
        minimize = FALSE,
        packages = "Metrics"
      )
    },

    calculate = function(e) {
      p = e$prediction
      Metrics::accuracy(actual = p$truth, predicted = p$response)
    }
  )
)

#' @include mlr_measures.R
mlr_measures$add("classif.acc", MeasureClassifACC)