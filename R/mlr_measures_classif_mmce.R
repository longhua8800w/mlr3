#' @title Mean Misclassification Error Measure
#'
#' @name mlr_measures_classif_mmce
#' @format [R6::R6Class()] inheriting from [MeasureClassif].
#'
#' @description
#' Calls [Metrics::ce].
#'
#' @export
#' @include MeasureClassif.R
MeasureClassifMMCE = R6Class("MeasureClassifMMCE",
  inherit = MeasureClassif,
  public = list(
    initialize = function() {
      super$initialize(
        id = "mmce",
        range = 0:1,
        minimize = TRUE,
        packages = "Metrics"
      )
    },

    calculate = function(e) {
      p = e$prediction
      Metrics::ce(actual = p$truth, predicted = p$response)
    }
  )
)


#' @include mlr_measures.R
mlr_measures$add("classif.mmce", MeasureClassifMMCE)