\name{estimateG}
\Rdversion{1.2}
\alias{estimateG}
\title{Estimate Treatment or Missingness Mechanism}
\description{
An internal function called by the \code{tmle} function to obtain an estimate of conditional treatment assignment probabiliites \eqn{P(A=1|W)}, and conditional probabilites for missingness, \eqn{P(Delta=1|A,W)}.  The estimate can be  based on user-supplied values, a user-supplied regression formula, or a data-adaptive super learner fit.  If the \code{SuperLearner} package is not available, and there are no user-specifications, estimation is carried out using main terms regression with \code{glm}.  These main terms-based estimates may yield poor results.
}
\usage{
estimateG(d, g1W, gform, SL.library, id, verbose, message, outcome, newdata=d)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{d}{dataframe with binary dependent variable in the first column, predictors in remaining columns}
  \item{g1W}{vector of values for \eqn{P(A=1|W)}, \eqn{P(Z=1|A,W)}, or \eqn{P(Delta=1|Z,A,W)}}
  \item{gform}{regression formula of the form \code{A~W1}, (dependent variable is one of \eqn{A,Z,D}) if specified this overrides the call to \code{SuperLearner}}
  \item{SL.library}{vector of prediction algorithms used by \code{SuperLearner}, default value is (\sQuote{SL.glm}, \sQuote{SL.step}, \sQuote{SL.glm.interaction})}
  \item{id}{subject identifier}
  \item{verbose}{status messages printed if set to TRUE}
  \item{message}{text specifies whether treatment or missingness mechanism is being estimated}
  \item{outcome}{\code{A, D, Z} to indicate which quantity is being estimated.}
  \item{newdata}{optional dataset to be used for prediction after fitting on \code{d}.}
}
\value{
 \item{g1W}{a vector containing values for \eqn{P(A=1|W)}, matrix for \eqn{P(Z=1|A,W)}, evaluated at A=0, A=1, or matrix \eqn{P(Delta=1|Z,A,W))} evaluated at (0,0), (0,1), (1,0), (1,1)}
  \item{coef}{coefficients for each term in the working model used for estimation if \code{glm} was used}
  \item{type}{estimation procedure}
}
\author{
Susan Gruber}
\seealso{
\code{\link{tmle}},
\code{\link{estimateQ}},
\code{\link{calcParameters}},
\code{\link{tmleMSM}},
\code{\link{calcSigma}}
}

