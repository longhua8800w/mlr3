#' @title Reflections for mlr3
#'
#' @description Environment which stores various information for reflections.
#' @keywords internal
#' @export
#' @examples
#' ls.str(mlr_reflections)
mlr_reflections = new.env(parent = emptyenv())


### DataBackend
mlr_reflections$databackend_formats = c(
  "data.table", "sparse"
)

### Task
mlr_reflections$task_types = c(
  "regr", "classif"
)

mlr_reflections$task_feature_types = c(
  lgl = "logical", int = "integer", dbl = "numeric", chr = "character", fct = "factor", ord = "ordered"
)

mlr_reflections$task_row_roles = c(
  "use", "validation"
)

mlr_reflections$task_col_roles = list(
  regr = c("feature", "target", "label", "order", "groups", "weights"),
  classif = c("feature", "target", "label", "order", "groups", "weights")
)

mlr_reflections$task_properties = list(
  classif = c("weights", "groups", "twoclass", "multiclass"),
  regr    = c("weights", "groups")
)


### Learner
mlr_reflections$learner_properties = list(
  classif = c("missings", "weights", "parallel", "twoclass", "multiclass", "importance", "selected_features"),
  regr    = c("missings", "weights", "parallel", "importance", "selected_features")
)

mlr_reflections$learner_predict_types = list(
  classif = c("response", "prob"),
  regr    = c("response", "se")
)

mlr_reflections$experiment_states = c("undefined", "defined", "trained", "predicted", "scored")

mlr_reflections$experiment_slots = data.table(
  name =   c("task",    "learner", "resampling", "iteration", "train_log",  "train_time", "predict_log", "predict_time", "prediction", "measures", "performance", "score_time"),
  type =   c("Task",    "Learner", "Resampling", "integer",   "data.table", "numeric",    "data.table",  "numeric",      "data.table", "list",     "list",        "numeric"),
  atomic = c(FALSE,     FALSE,     FALSE,        TRUE,        FALSE,        TRUE,         FALSE,         TRUE,           FALSE,        FALSE,      FALSE,         TRUE),
  state =  c("defined", "defined", "trained",    "trained",   "trained",    "trained",    "predicted",   "predicted",    "predicted",  "scored",   "scored",      "scored")
)

mlr_reflections$experiment_slots$state = ordered(mlr_reflections$experiment_slots$state, levels = mlr_reflections$experiment_states)

### Log

mlr_reflections$log_classes = c("output", "warning", "error")
