\name{SL.glm.interaction}
\Rdversion{1.2}
\alias{SL.glm.interaction}
\title{Wrapper function for SuperLearner prediction algorithm}
\description{
A function in the default \code{SuperLearner} library used by \code{tmle}. This wrapper is built into \code{SuperLearner 2.0-6}, and is defined here for backwards-compatibility with older versions of \code{SuperLearner}. This function may be incorporated into any user-supplied \code{SuperLearner} library, but will not ordinarily be called directly by the user.
}
\usage{
SL.glm.interaction(Y.temp, X.temp, newX.temp, family, obsWeights, ...)
}
\arguments{
  \item{Y.temp}{The outcome}
  \item{X.temp}{The training data set}
  \item{newX.temp}{The validation data set (the observations to make predictions from)}
  \item{family}{outcome distribution, either \code{gaussian} or \code{binomial}}
  \item{obsWeights}{observation weights, currently unused}
  \item{...}{additional arguments}
}
\value{
 \item{out}{The predicted outcome on the scale of the outcome}
  \item{fit}{A list of elements needed for the predict method on the specific algorithm}
}
\author{
Susan Gruber}