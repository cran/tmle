\name{calcSigma}
\Rdversion{1.2.0-5}
\alias{calcSigma}
\title{Calculate Variance-Covariance Matrix for MSM Parameters (calcSigma)}
\description{
An internal function called by the \code{tmleMSM} function to calculate the variance-covariance matrix of the 
parameter estimates based on the influence curve of the specified MSM.}
\usage{
calcSigma(hAV, gAVW, Y, Q, mAV, covar.MSM, covar.MSMA0, covar.MSMA1, I.V, 
     Delta, ub, id, family)
}
\arguments{
  \item{hAV}{values used in numerator of weights applied to the estimation procedure}
  \item{gAVW}{\eqn{p(A=a | V,W,T)*p(Delta=1 | A,V,W,T}}
  \item{Y}{continuous or binary outcome variable}
  \item{Q}{estimated \eqn{P(Y | A, V, W, T, Delta=1}, typically targeted values \code{Q*} are passed in}
  \item{mAV}{predicted values for \eqn{EY1} from the MSM using the targeted estimates for \eqn{psi}}
  \item{covar.MSM}{covariate values used as predictors for the MSM when \code{A=a}}
  \item{covar.MSMA0}{covariate values used as predictors for the MSM when \code{A=0}}
  \item{covar.MSMA1}{covariate values used as predictors for the MSM when \code{A=1}}
  \item{I.V}{indicator that observation is in stratum of interest} 
  \item{Delta}{indicator of missing outcome. \code{1} - observed, \code{0} - missing}
  \item{ub}{upper bound on weights}
  \item{id}{subject identifier}
  \item{family}{\sQuote{gaussian} for continuous outcomes, \sQuote{binomial} for binary outcomes}
}
\value{
  \item{sigma}{influence-curve based variance-covariance matrix. See Rosenblum&vanderLaan2010 for details.}
}

\author{Susan Gruber}

\seealso{
\code{\link{tmle}},
\code{\link{estimateQ}},
\code{\link{estimateG}},
\code{\link{tmleMSM}}
}
