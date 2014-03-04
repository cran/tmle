\name{summary.tmleMSM}
\Rdversion{1.2.0-4}
\alias{summary.tmleMSM}
\alias{print.summary.tmleMSM}
\alias{print.tmleMSM}
\title{Summarization of the results of a call to the tmleMSM function}
\description{
These functions are all \link{methods} for class \code{tmleMSM}, \code{summary.tmleMSM} objects}
\usage{
\method{summary}{tmleMSM}(object, \dots)
\method{print}{tmleMSM}(x, \dots)
\method{print}{summary.tmleMSM}(x, \dots)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{an object of class \code{tmleMSM}.} 
  \item{x}{an object of class \code{tmleMSM} for summary functions, class \code{summary.tmleMSM} for print functions.}
  \item{\dots}{currently ignored.}
}
\value{
  \item{estimates}{matrix of MSM parameter estimates, standard errors, pvalues, upper and lower bounds on 95\% confidence intervals}
  \item{sigma}{variance-covariance matrix}
  \item{Qmodel}{working model used to obtain initial estimate of \code{Q} portion of the likelihood, if \code{glm} used}
  \item{Qterms}{terms in the model for \code{Q}}
  \item{Qcoef}{coefficient of each term in model for \code{Q}}
  \item{gmodel}{model used to estimate treatment mechanism \code{g}}
  \item{gterms}{terms in the treatment mechanism model}
  \item{gcoef}{coefficient of each term in model for treatment mechanism}
  \item{gtype}{description of estimation procedure for treatment mechanism, e.g. "SuperLearner"}
  \item{g.AVmodel}{model used to estimate h(A,V) (or h(A,T))}
  \item{g.AVterms}{terms in the model for h(A,V)}
  \item{g.AVcoef}{coefficient of each term in model for h(A,V)}
  \item{g.AVtype}{description of estimation procedure for h(A,V)}
  \item{g.Deltamodel}{model used to estimate missingness mechanism \code{g.Delta}}
  \item{g.Deltaterms}{terms in the missingness mechanism model}
  \item{g.Deltacoef}{coefficient of each term in model for missingness mechanism}
  \item{g.Deltatype}{description of estimation procedure for missingness}
  \item{psi.Qinit}{MSM parameter estimates based on initial (untargeted) estimated \code{Q}}
}
\details{\code{print.tmleMSM} prints the estimate, standard error, p-value, and 95\% confidence interval only.  \code{print.summary.tmleMSM}, called indirectly by entering the command \kbd{summary(result)} (where \code{result} has class \code{tmleMSM}), outputs additional information.} 
\author{Susan Gruber}

\seealso{
\code{\link{tmleMSM}}
}


