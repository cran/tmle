\name{summary.tmle}
\Rdversion{1.3.0-1}
\alias{summary.tmle}
\alias{print.summary.tmle}
\alias{print.tmle}
\alias{summary.tmle.list}
\alias{print.summary.tmle.list}
\alias{print.tmle.list}
\title{Summarization of the results of a call to the tmle routine}
\description{
These functions are all \link{methods} for class \code{tmle}, \code{tmle.list}, \code{summary.tmle}, \code{summary.tmle.list} objects}
\usage{
\method{summary}{tmle}(object, \dots)
\method{summary}{tmle.list}(object, \dots)
\method{print}{tmle}(x, \dots)
\method{print}{tmle.list}(x, \dots)
\method{print}{summary.tmle}(x, \dots)
\method{print}{summary.tmle.list}(x, \dots)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{an object of class \code{tmle} or \code{tmle.list}.} 
  \item{x}{an object of class \code{tmle} or \code{tmle.list} for summary functions, class \code{summary.tmle} or \code{summary.tmle.list} for print functions.}
  \item{\dots}{currently ignored.}
}
\value{
  \item{estimates}{list of parameter estimates, pvalues, and 95\% confidence intervals}
  \item{Qmodel}{working model used to obtain initial estimate of \code{Q} portion of the likelihood, if \code{glm} used}
  \item{Qterms}{terms in the model for \code{Q}}
  \item{Qcoef}{coefficient of each term in model for \code{Q}}
  \item{gmodel}{model used to estimate treatment mechanism \code{g}}
  \item{gterms}{terms in the treatment mechanism model}
  \item{gcoef}{coefficient of each term in model for treatment mechanism}
  \item{gtype}{description of estimation procedure for treatment mechanism, e.g. "SuperLearner"}
  \item{g.Zmodel}{model used to estimate intermediate variable assignment mechanism \code{g.Z}}
  \item{g.Zterms}{terms in the intermediate mechanism model}
  \item{g.Zcoef}{coefficient of each term in model for intermediate mechanism}
  \item{g.Ztype}{description of estimation procedure for intermediate variable}
  \item{g.Deltamodel}{model used to estimate missingness mechanism \code{g.Delta}}
  \item{g.Deltaterms}{terms in the missingness mechanism model}
  \item{g.Deltacoef}{coefficient of each term in model for missingness mechanism}
  \item{g.Deltatype}{description of estimation procedure for missingness}
}
\details{\code{print.tmle} prints the estimate, variance, p-value, and 95\% confidence interval only.  \code{print.summary.tmle}, called indirectly by entering the command \kbd{summary(result)} (where \code{result} has class \code{tmle}), outputs additional information.  Controlled direct effect estimates have class \code{tmle.list},  a list of two objects of class \code{tmle}.  The first item corresponds to \eqn{Z=0}, the second to \eqn{Z=1}}  
\author{Susan Gruber}

\seealso{
\code{\link{tmle}}
}
\examples{
# generate data
  set.seed(10)
  n <- 500
  W <- matrix(rnorm(n*3), ncol=3)
  A <- rbinom(n,1, 1/(1+exp(-(.1*W[,1] - .1*W[,2] + .5*W[,3]))))
  Y <- A + 2*W[,1] + W[,3] + W[,2]^2 + rnorm(n)
  colnames(W) <- paste("W",1:3, sep="")

  result <- tmle(Y,A,W, Qform="Y~A+W1", g1W=rep(.5, n))
  summary(result)
}

