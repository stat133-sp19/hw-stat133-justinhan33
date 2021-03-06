% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/main.R
\name{bin_distribution}
\alias{bin_distribution}
\title{Distribution function}
\usage{
bin_distribution(trials, prob)
}
\arguments{
\item{trials}{number of trials (numeric)}

\item{prob}{probability of success (numeric)}
}
\value{
Data frame with sucesses in the first column and probability in the second column
}
\description{
Generates a data frame with the probability distribution
}
\examples{

#binomial probability distribution
 bin_distribution(trials = 5, prob = 0.5)

}
