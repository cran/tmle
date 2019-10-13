\name{oneStepATT}
\Rdversion{1.4.0}
\alias{oneStepATT}
\title{Calculate Additive treatment effect among the treated (oneStepATT)}
\description{
An internal function called by the \code{tmle} function to calculate the additive treatment effect among the treated (ATT) using a universal least favorable submodel (on the transformed scale if outcomes are continuous). The function is called a second time with updated arguments to calculate the additive treatment effect among the controls (ATC). Missingness in the outcome data is allowed.
}
\usage{
oneStepATT(Y, A, Delta, Q, g1W, pDelta1, depsilon, max_iter, gbounds, Qbounds)
}
\arguments{
  \item{Y}{continuous or binary outcome variable}
  \item{A}{binary treatment indicator, \code{1} - treatment, \code{0} - control}
  \item{Delta}{indicator of missing outcome. \code{1} - observed, \code{0} - missing}
  \item{Q}{a 3-column matrix \code{(Q(A,W), Q(1,W), Q(0,W))}}
  \item{g1W}{treatment mechanism estimates, \eqn{P(A=1|W)}}
  \item{pDelta1}{censoring mechanism estimates, a 2-column matrix [\eqn{P(Delta=1|A=0,W)}, \eqn{P(Delta=1|A=1,W)}]}
  \item{depsilon}{step size for delta moves, set to 0.001}
  \item{max_iter}{maximum number of iterations before terminating without convergence}
  \item{gbounds}{bounds on the propensity score for untreated subjects}
  \item{Qbounds}{alpha bounds on the logit scale}
}
\value{
  \item{psi}{effect estimate (on the transformed scale for continuous outcomes)}
  \item{IC}{influence function}
  \item{conv}{TRUE if procedure converged, FALSE otherwise}
}

\author{Susan Gruber}

\seealso{
\code{\link{tmle}},
}
