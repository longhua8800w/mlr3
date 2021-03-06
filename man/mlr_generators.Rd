% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mlr_generators.R
\name{mlr_generators}
\alias{mlr_generators}
\title{Dictionary of Task Generators}
\description{
A simple \link{Dictionary} storing generator functions returning a \link{Task}.
}
\section{Usage}{

See \link{Dictionary}.
}

\examples{
g = mlr_generators$get("smiley")
task = g$generate(10)
print(task)
task$data()
}
\seealso{
Other Dictionary: \code{\link{Dictionary}},
  \code{\link{mlr_learners}}, \code{\link{mlr_measures}},
  \code{\link{mlr_resamplings}}, \code{\link{mlr_tasks}}

Other Task: \code{\link{TaskClassif}},
  \code{\link{TaskRegr}}, \code{\link{TaskSupervised}},
  \code{\link{Task}}, \code{\link{mlr_tasks}}
}
\concept{Dictionary}
\concept{Generator}
\concept{Task}
