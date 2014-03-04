\name{tmle}
\Rdversion{1.2.0-4}
\alias{tmle}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Targeted Maximum Likelihood Estimation}
\description{
Targeted maximum likelihood estimation of parameters of a marginal structural model, and of marginal treatment effects of a binary point treatment on an outcome. In addition to the additive treatment effect, risk ratio and odds ratio estimates are reported for binary outcomes. The \code{tmle} function is generally called with arguments \code{(Y,A,W)}, where  \code{Y} is a continuous or binary outcome variable, \code{A} is a binary treatment variable, (\code{A=1} for treatment, \code{A=0} for control), and \code{W} is a matrix or dataframe of baseline covariates. The population mean outcome is calculated when there is no variation in \code{A}. If values of binary mediating variable \code{Z} are supplied, estimates are returned at each level of \code{Z}. Missingness in the outcome is accounted for in the estimation procedure if missingness indicator \code{Delta} is 0 for some observations.  Repeated measures can be identified using the \code{id} argument.}
\usage{
tmle(Y, A, W, Z=NULL, Delta = rep(1,length(Y)), Q = NULL, Q.Z1 = NULL, Qform = NULL, 
     Qbounds = NULL, Q.SL.library = c("SL.glm", "SL.step", "SL.glm.interaction"), 
     cvQinit = FALSE, g1W = NULL, gform = NULL, gbound = 0.025,  pZ1=NULL,
     g.Zform = NULL, pDelta1 = NULL, g.Deltaform = NULL, 
     g.SL.library = c("SL.glm", "SL.step", "SL.glm.interaction"),
     family = "gaussian", fluctuation = "logistic", alpha = 0.995, id=1:length(Y), 
     verbose = FALSE)
}
\arguments{
 \item{Y}{continuous or binary outcome variable}
  \item{A}{binary treatment indicator, \code{1} - treatment, \code{0} - control}
  \item{W}{vector, matrix, or dataframe containing baseline covariates}
  \item{Z}{optional binary indicator for intermediate covariate for conrolled direct effect estimation}
  \item{Delta}{indicator of missing outcome or treatment assignment.  \code{1} - observed, \code{0} - missing}
  \item{Q}{optional \eqn{nx2} matrix of initial values for \eqn{Q} portion of the likelihood, \eqn{(E(Y|A=0,W), E(Y|A=1,W))}}
  \item{Q.Z1}{optional \eqn{nx2} matrix of initial values for \eqn{Q} portion of the likelihood, \eqn{(E(Y|Z=1,A=0,W), E(Y|Z=1,A=1,W))}. (When specified, values for \eqn{E(Y|Z=0,A=0,W), E(Y|Z=0,A=1,W)} are passed in using the \code{Q} argument}
 \item{Qform}{optional regression formula for estimation of \eqn{E(Y|A,W)}, suitable for call to \code{glm}}
  \item{Qbounds}{vector of upper and lower bounds on \code{Y} and predicted values for initial \code{Q}. Defaults to the range of \code{Y}, widened by 10\% of the min and max values.}
  \item{Q.SL.library}{optional vector of prediction algorithms to use for \code{SuperLearner} estimation of initial \code{Q}}
  \item{cvQinit}{logical, if \code{TRUE}, estimates cross-validated predicted values using discrete super learning, default=\code{FALSE}}
  \item{g1W}{optional vector of conditional treatment assingment probabilities, \eqn{P(A=1|W)}}
  \item{gform}{optional regression formula of the form \code{A~W}, if specified this overrides the call to \code{SuperLearner}}
  \item{gbound}{value between (0,1) for truncation of predicted probabilities. See \code{Details} section for more information}
  \item{pZ1}{optional\eqn{nx2} matrix of conditional probabilities \eqn{P(Z=1|A=0,W), P(Z=1|A=1,W)}} 
  \item{g.Zform}{optionalregression formula of the form \code{Z~A+W}, if specified this overrides the call to \code{SuperLearner}} 
  \item{pDelta1}{optional matrix of conditional probabilities for missingness mechanism, \eqn{nx2} when \code{Z} is \code{NULL} \eqn{P(Delta=1|A=0,W), P(Delta=1|A=1,W)}. \eqn{nx4} otherwise, \eqn{P(Delta=1|Z=0,A=0,W), P(Delta=1|Z=0,A=1,W), P(Delta=1|Z=1,A=0,W), P(Delta=1|Z=1,A=1,W)}}
  \item{g.Deltaform}{optional regression formula of the form \code{Delta~A+W}, if specified this overrides the call to \code{SuperLearner}}
  \item{g.SL.library}{optional vector of prediction algorithms to use for \code{SuperLearner} estimation of \code{g1W} or \code{pDelta1} }
  \item{family}{family specification for working regression models, generally \sQuote{gaussian} for continuous outcomes (default), \sQuote{binomial} for binary outcomes}
  \item{fluctuation}{\sQuote{logistic} (default), or \sQuote{linear}}
  \item{alpha}{used to keep predicted initial values bounded away from (0,1) for logistic fluctuation}
  \item{id}{optional subject identifier}
  \item{verbose}{status messages printed if set to \code{TRUE} (default=\code{FALSE})}
}
\details{
 \code{gbounds} defaults to (0.025, 0.975) for treatment effect estimates. If only one value is provided,  symmetric truncation levels are assumed. Bounds default to (0.025, 1) for estimating the population mean outcome.  

\code{W} should only contain covariates that are factors when \code{Super Learner} is not used to estimate \code{Q} or \code{g}.

 Controlled direct effects are estimated when binary covariate \code{Z} is non-null. The tmle function returns an object of class \code{tmle.list}, a list of two items of class \code{tmle}.  The first corresponds to estimates obtained when \code{Z} is fixed at \eqn{0}, the second correspondes to estimates obtained when \code{Z} is fixed at \eqn{1}.

 \code{Q.SL.library} defaults to (\sQuote{SL.glm}, \sQuote{SL.step}, \sQuote{SL.glm.interaction})

 \code{g.SL.library} Defaults to (\sQuote{SL.glm}, \sQuote{SL.step}, \sQuote{SL.glm.interaction})

 This choice is simply because these algorithms are included in the base \code{R} installation. See \code{SuperLearner} help files for further information.
}
\value{
  \item{estimates}{list with elements EY1 (population mean), ATE (additive treatment effect), RR (relative risk), OR (odds ratio). Each element in the estimates of these is itself a list containing 
 \itemize{
  \item psi - parameter estimate 
  \item pvalue - two-sided p-value
  \item CI - 95\% confidence interval
  \item var.psi - Influence-curve based variance of estimate (ATE parameter only)
  \item log.psi - Parameter estimate on log scale (RR and OR parameters)
  \item var.log.psi - Influence-curve based variance of estimate on log scale (RR and OR parameters)
  }}
  \item{Qinit}{initial estimate of \code{Q}. \code{Qinit$coef} are the coefficients for a \code{glm} model for \code{Q}, if applicable.  \code{Qinit$Q} is an \eqn{nx2} matrix, where \code{n} is the number of observations.  Columns contain predicted values for \code{Q(0,W),Q(1,W)} using the initial fit.  \code{Qinit$type} is method for estimating \code{Q}}
  \item{Qstar}{targeted estimate of \code{Q}, an \eqn{nx2} matrix with predicted values for \code{Q(0,W), Q(1,W)} using the updated fit}
  \item{g}{treatment mechanism estimate. A list with three items: \code{g$g1W} contains estimates of \eqn{P(A=1|W)} for each observation, \code{g$coef} the coefficients for the model for \eqn{g} when \code{glm} used, \code{g$type} estimation procedure}
  \item{g.Z}{intermediate covariate assignment estimate (when applicable). A list with three items: \code{g.Z$g1W} an \eqn{nx2} matrix containing values of \eqn{P(Z=1|A=1,W), P(Z=1|A=0,W)} for each observation, \code{g.Z$coef} the coefficients for the model for \eqn{g} when \code{glm} used, \code{g.Z$type} estimation procedure}
  \item{g.Delta}{missingness mechanism estimate. A list with three items: \code{g.Delta$g1W} an \eqn{nx4} matrix containing values of \eqn{P(Delta=1|Z,A,W)} for each observation, with (Z=0,A=0), (Z=0,A=1), (Z=1,A=0),(Z=1,A=1). (When \code{Z} is \code{NULL}, columns 3 and 4 are duplicates of 1 and 2.) \code{g.Delta$coef} the coefficients for the model for \eqn{g} when \code{glm} used, \code{g.Delta$type} estimation procedure}
}
\references{
1. Gruber, S. and van der Laan, M.J. (2012), {tmle: An R Package for Targeted Maximum Likelihood Estimation}. \emph{Journal of Statistical Software}, 51(13), 1-35. \url{http://www.jstatsoft.org/v51/i13/}

2. Gruber, S. and van der Laan, M.J. (2009), {Targeted Maximum Likelihood Estimation: A Gentle Introduction}. \emph{U.C. Berkeley Division of Biostatistics Working Paper Series}.  Working Paper 252.  \url{http://www.bepress.com/ucbbiostat/paper252}

3. Gruber, S. and van der Laan, M.J.  (2010), {A Targeted Maximum Likelihood Estimator of a Causal Effect on a Bounded Continuous Outcome}. \emph{The International Journal of Biostatistics}, 6(1), 2010.

4. Rosenblum, M. and van der Laan, M.J. (2010).{Targeted Maximum Likelihood Estimation of the Parameter of a Marginal Structural Model}. \emph{The International Journal of Biostatistics}, 6(2), 2010.

5. van der Laan, M.J. and Rubin, D. (2006), {Targeted Maximum Likelihood Learning}. \emph{The International Journal of Biostatistics}, 2(1). \url{http://www.bepress.com/ijb/vol2/iss1/11/}

6. van der Laan, M.J., Rose, S., and Gruber,S., editors, (2009) {Readings in Targeted Maximum Likelihood Estimation} . \emph{U.C. Berkeley Division of Biostatistics Working Paper Series}.  Working Paper 254. \url{http://www.bepress.com/ucbbiostat/paper254}
}

\author{Susan Gruber \email{sgruber@cal.berkeley.edu}, in collaboration with Mark van der Laan.}


\seealso{
\code{\link{summary.tmle}},
\code{\link{estimateQ}},
\code{\link{estimateG}},
\code{\link{calcParameters}},
\code{\link{tmleMSM}},
\code{\link{calcSigma}}
}
\examples{
library(tmle)
  set.seed(1)
  n <- 250
  W <- matrix(rnorm(n*3), ncol=3)
  A <- rbinom(n,1, 1/(1+exp(-(.2*W[,1] - .1*W[,2] + .4*W[,3]))))
  Y <- A + 2*W[,1] + W[,3] + W[,2]^2 + rnorm(n)

# Example 1. Simplest function invocation 
# SuperLearner called to estimate Q, g
# Delta defaults to 1 for all observations   
  result1 <- tmle(Y,A,W)
  summary(result1)

# Example 2: 
# User-supplied regression formulas to estimate Q and g
# binary outcome
 # n <- 250
  W <- matrix(rnorm(n*3), ncol=3)
  colnames(W) <- paste("W",1:3, sep="")
  A <- rbinom(n,1, plogis(0.6*W[,1] +0.4*W[,2] + 0.5*W[,3]))
  Y <- rbinom(n,1, plogis(A + 0.2*W[,1] + 0.1*W[,2] + 0.2*W[,3]^2 ))
  result2 <- tmle(Y,A,W, family="binomial", Qform=Y~A+W1+W2+W3, gform=A~W1+W2+W3)
  summary(result2)

# Example 3: Population mean outcome
# User-supplied (misspecified) model for Q, 
# Super learner called to estimate g, g.Delta
# approx. 20% missing at random
  Y <- W[,1] + W[,2]^2 + rnorm(n)
  Delta <- rbinom(n, 1, 1/(1+exp(-(1.7-1*W[,1]))))
  result3 <- tmle(Y,A=NULL,W, Delta=Delta, Qform="Y~A+W1+W2+W3")
  print(result3)

# Example 4: Controlled direct effect
# User-supplied models for g, g.Z
  A <- rbinom(n,1,.5)
  Z <- rbinom(n, 1, plogis(.5*A + .1*W[,1]))
  Y <- 1 + A + 10*Z + W[,1]+ rnorm(n)
  
  CDE <- tmle(Y,A,W, Z, gform="A~1", g.Zform = "Z ~ A + W1")
  total.effect <- tmle(Y,A, W,  gform="A~1")
  print(CDE)
  print(total.effect)
}
