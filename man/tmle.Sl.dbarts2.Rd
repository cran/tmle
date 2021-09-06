\name{tmle.SL.dbarts2}
\Rdversion{1.5.0.2}
\alias{tmle.SL.dbarts2}
\alias{tmle.SL.dbarts.k.5}
\alias{predict.tmle.SL.dbarts2}
\title{Super Learner wrappers for modeling and prediction using \code{bart} in the \code{dbarts} package}
\description{These functions are used internally, not typically called by the user}
\usage{
tmle.SL.dbarts2(Y, X, newX, family, obsWeights, id, sigest = NA, sigdf = 3, 
	sigquant = 0.90, k = 2, power = 2.0, base = 0.95, binaryOffset = 0.0, 
	ntree = 200, ndpost = 1000, nskip = 100, printevery = 100,  keepevery = 1,  
	keeptrainfits = TRUE, usequants = FALSE, numcut = 100,printcutoffs = 0,  
	nthread = 1,   keepcall = TRUE,verbose = FALSE, ...)
tmle.SL.dbarts.k.5(Y, X, newX, family, obsWeights, id, sigest = NA, sigdf = 3, 
	sigquant = 0.90, k = 0.5, power = 2.0, base = 0.95, binaryOffset = 0.0, 
	ntree = 200, ndpost = 1000, nskip = 100, printevery = 100,  keepevery = 1,  
	keeptrainfits = TRUE, usequants = FALSE, numcut = 100,printcutoffs = 0,  
	nthread = 1,   keepcall = TRUE,verbose = FALSE, ...)
\method{predict}{tmle.SL.dbarts2}(object, newdata, family, \ldots)
}
\arguments{
 \item{Y}{Dependent variable}
\item{X}{Predictor covariate matrix or data frame used as training set}
\item{newX}{Predictor covariate matrix or data frame for which predictions should be made}
\item{family}{Regression family, 'gaussian' or 'binomial'}
\item{obsWeights}{observation-level weights}
\item{id}{id}{id to group observations, not used}
\item{sigest}{An estimate of error variance. See \code{bart} documentation}
\item{sigdf}{Degrees of freedom for error variance prior. See \code{bart} documentation}
\item{sigquant}{Quantile of error variance prior. See \code{bart} documentation}
\item{k}{Tuning parameter that controls smoothing. Larger values are more conservative, see \code{Details}}
\item{power}{Power parameter for tree prior}
\item{base}{Base parameter for tree prior}
\item{binaryOffset}{Allows fits with probabilities shrunk towards values other than 0.5. See \code{bart} documentation}
\item{ntree}{Number of trees in the sum-of-trees formulation}
\item{ndpost}{Number of posterior draws after burn in}
\item{nskip}{Number of MCMC iterations treated as burn in}
\item{printevery}{How often to print messages}
\item{keepevery}{Every \code{keepevery} draw is kept to be returned to the user}
\item{keeptrainfits}{If \code{TRUE} the draws of \eqn{f(x)} for \eqn{x} corresponding to the rows of \code{x.train} are returned}
\item{usequants}{Controls how tree decisions rules are determined. See \code{bart} documentation}
\item{numcut}{Maximum number of possible values used in decision rules}
\item{printcutoffs}{Number of cutoff rules to print to screen. \eqn{0} prints nothing}
\item{nthread}{Integer specifying how many threads to use}
\item{keepcall}{Returns the call to BART when \code{TRUE}}
\item{verbose}{Ignored for now}
\item{\ldots}{Additional arguments passed on to plot or control functions}
\item{object}{object of type tmle.SL.dbarts2}
\item{newdata}{matrix or dataframe used to get predictions from the fitted model}
}
\value{
{object}{an object of type tmle.SL.dbarts2 used internally by \code{Super Learner}}
}
\details{\code{tmle.SL.dbarts2} is in the default library for estimating \eqn{Q}. It uses the default setting in the \code{dbarts} package, \eqn{k=2}. \code{tmle.SL.dbarts.k.5} is used to estimate the components of \eqn{g}. It sets \eqn{k=0.5}, to avoid shrinking predicted values too far from \eqn{(0,1)}. See \code{bart} documentation for more information.
}
\author{Chris Kennedy and Susan Gruber}
\seealso{
\code{\link{SuperLearner}}
}
