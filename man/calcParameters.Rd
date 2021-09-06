\name{calcParameters}
\Rdversion{1.5.0.2}
\alias{calcParameters}
\title{Calculate Parameter Estimates (calcParameters)}
\description{
An internal function called by the \code{tmle} function to calculate the population mean effect when there is missingness in the data, but no treatment assignment.  When observations are in treatment and control groups, estimates the additive treatment effect among the entire population (ATE), among the treated (ATT), and among the controls (ATC). If the outcome is binary, also the relative risk and odds ratio parameters.  P-values and 95\% confidence intervals are also calculated (on the log scale for RR and OR).
}
\usage{
calcParameters(Y, A, I.Z, Delta, g1W, g0W, Q, mu1, mu0, id, family)
}
\arguments{
  \item{Y}{continuous or binary outcome variable}
  \item{A}{binary treatment indicator, \code{1} - treatment, \code{0} - control}
  \item{I.Z}{Indicator Z=z, needed for CDE estimation}
  \item{Delta}{indicator of missing outcome. \code{1} - observed, \code{0} - missing}
  \item{g1W}{censoring mechanism estimates, \eqn{P(A=1|W)*P(Delta=1|A,W)}}
  \item{g0W}{censoring mechanism estimates, \eqn{P(A=0|W)*P(Delta=1|A,W)}}
  \item{Q}{a 3-column matrix \code{(Q(A,W), Q(1,W), Q(0,W))}}
  \item{mu1}{targeted estimate of \eqn{E(Y|A=1,W)}}
  \item{mu0}{targeted estimate of \eqn{E(Y|A=0,W)}}
  \item{id}{subject identifier}
  \item{family}{family specification for regressions, generally \sQuote{gaussian} for continuous outcomes, \sQuote{binomial} for binary outcomes}
}
\value{
  \item{EY1}{Population mean outcome estimate, variance, p-value, 95\% confidence interval (missingness only, no treatment assignment), or \code{NULL}}
  \item{ATE}{additive treatment effect estimate, variance, p-value, 95\% confidence interval, or \code{NULL}}
  \item{RR}{relative risk estimate, p-value, 95\% confidence interval, log(RR), variance(log(RR)), or \code{NULL}}
  \item{OR}{odds ratio estimate, p-value, 95\% confidence interval, log(OR), variance(log(OR)), or \code{NULL}}
}

\author{Susan Gruber}

\seealso{
\code{\link{tmle}},
\code{\link{estimateQ}},
\code{\link{estimateG}},
\code{\link{tmleMSM}},
\code{\link{calcSigma}}
}
