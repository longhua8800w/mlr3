#' @title Resample a Learner on a Task
#'
#' @description
#' Runs a resampling (possibly in parallel).
#'
#' @param task ([Task]):
#'   Object of type [Task].
#' @param learner ([Learner]):
#'   Object of type [Learner].
#' @param resampling ([Resampling]):
#'   Object of type [Resampling].
#' @param ctrl (named `list()`, e.g. as returned by [mlr_control()]):
#'   Object to control various parts of the execution. See [mlr_control()].
#' @return [ResampleResult].
#' @export
#' @examples
#' \dontshow{
#'    .threshold = logger::log_threshold(namespace = "mlr3")
#'    logger::log_threshold(logger::WARN, namespace = "mlr3")
#' }
#' task = mlr_tasks$get("iris")
#' learner = mlr_learners$get("classif.rpart")
#' resampling = mlr_resamplings$get("cv")
#'
#' # explicitly instantiate the resampling for this task for reproduciblity
#' set.seed(123)
#' resampling$instantiate(task)
#'
#' rr = resample(task, learner, resampling)
#' print(rr, digits = 2)
#' rr$aggregated
#' rr$performance("classif.mmce")
#'
#' # Repeat resampling with featureless learner and combine
#' # the ResampleResults into a BenchmarkResult
#' learner = mlr_learners$get("classif.featureless")
#' rr.featureless = resample(task, learner, resampling)
#'
#' bmr = rr$combine(rr.featureless)
#' bmr$aggregated(objects = FALSE)
#'
#'
#' \dontshow{
#'    logger::log_threshold(.threshold, namespace = "mlr3")
#' }
resample = function(task, learner, resampling, ctrl = list()) {
  task = assert_task(task)$clone(deep = TRUE)
  learner = assert_learner(learner, task = task)$clone(deep = TRUE)
  assert_resampling(resampling)
  measures = assert_measures(task$measures, task = task)
  ctrl = mlr_control(ctrl)

  instance = resampling$clone(deep = TRUE)
  if (!instance$is_instantiated)
    instance = instance$instantiate(task)
  n = instance$iters

  if (future_remote()) {
    log_debug("Running resample() via future with %i iterations", n, namespace = "mlr3")
    res = future.apply::future_lapply(seq_len(n), experiment_worker,
      task = task, learner = learner, resampling = instance, measures = measures, ctrl = ctrl,
      remote = TRUE, future.globals = FALSE, future.scheduling = structure(TRUE, ordering = "random"),
      future.packages = "mlr3")
  } else {
    log_debug("Running resample() sequentially with %i iterations", n, namespace = "mlr3")
    res = lapply(seq_len(n), experiment_worker,
      task = task, learner = learner, resampling = instance, measures = measures, ctrl = ctrl)
  }

  res = combine_experiments(res)
  res[, c("task", "resampling", "measures") := list(list(task), list(instance), list(measures))]
  ResampleResult$new(res)
}
