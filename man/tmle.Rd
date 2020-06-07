\name{tmle}
\Rdversion{1.5.0-1}
\alias{tmle}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Targeted Maximum Likelihood Estimation}
\description{
Targeted maximum likelihood estimation of parameters of a marginal structural model, and of marginal treatment effects of a binary point treatment on an outcome. In addition to the additive treatment effect, risk ratio and odds ratio estimates are reported for binary outcomes. The \code{tmle} function is generally called with arguments \code{(Y,A,W)}, where  \code{Y} is a continuous or binary outcome variable, \code{A} is a binary treatment variable, (\code{A=1} for treatment, \code{A=0} for control), and \code{W} is a matrix or dataframe of baseline covariates. The population mean outcome is calculated when there is no variation in \code{A}. If values of binary mediating variable \code{Z} are supplied, estimates are returned at each level of \code{Z}. Missingness in the outcome is accounted for in the estimation procedure if missingness indicator \code{Delta} is 0 for some observations.  Repeated measures can be identified using the \code{id} argument.}
\usage{
tmle(Y, A, W, Z=NULL, Delta = rep(1,length(Y)), Q = NULL, Q.Z1 = NULL, Qform = NULL, 
     Qbounds = NULL, Q.SL.library = c("SL.glm", "tmle.SL.dbarts2", "SL.glmnet"), 
     cvQinit = TRUE, g1W = NULL, gform = NULL, 
     gbound = 5/sqrt(length(Y))/log(length(Y)),  pZ1=NULL,
     g.Zform = NULL, pDelta1 = NULL, g.Deltaform = NULL, 
     g.SL.library = c("SL.glm", "tmle.SL.dbarts.k.5", "SL.gam"),
     g.Delta.SL.library =  c("SL.glm", "tmle.SL.dbarts.k.5", "SL.gam"),
     family = "gaussian", fluctuation = "logistic", alpha = 0.9995, id=1:length(Y), V = 5,
     verbose = FALSE, Q.discreteSL=FALSE, g.discreteSL=FALSE, g.Delta.discreteSL=FALSE,
     prescreenW.g=TRUE, min.retain = 2, RESID=FALSE, target.gwt = TRUE, automate=FALSE)
}
\arguments{
 \item{Y}{continuous or binary outcome variable}
  \item{A}{binary treatment indicator, \code{1} - treatment, \code{0} - control}
  \item{W}{vector, matrix, or dataframe containing baseline covariates}
  \item{Z}{optional binary indicator for intermediate covariate for controlled direct effect estimation}
  \item{Delta}{indicator of missing outcome or treatment assignment.  \code{1} - observed, \code{0} - missing}
  \item{Q}{optional \eqn{nx2} matrix of initial values for \eqn{Q} portion of the likelihood, \eqn{(E(Y|A=0,W), E(Y|A=1,W))}}
  \item{Q.Z1}{optional \eqn{nx2} matrix of initial values for \eqn{Q} portion of the likelihood, \eqn{(E(Y|Z=1,A=0,W), E(Y|Z=1,A=1,W))}. (When specified, values for \eqn{E(Y|Z=0,A=0,W), E(Y|Z=0,A=1,W)} are passed in using the \code{Q} argument}
 \item{Qform}{optional regression formula for estimation of \eqn{E(Y|A,W)}, suitable for call to \code{glm}}
  \item{Qbounds}{vector of upper and lower bounds on \code{Y} and predicted values for initial \code{Q}. Defaults to the range of \code{Y}, widened by 10\% of the min and max values.}
  \item{Q.SL.library}{optional vector of prediction algorithms to use for \code{SuperLearner} estimation of initial \code{Q}}
  \item{cvQinit}{logical, if \code{TRUE}, estimates cross-validated predicted values, default=\code{TRUE}}
  \item{g1W}{optional vector of conditional treatment assingment probabilities, \eqn{P(A=1|W)}}
  \item{gform}{optional regression formula of the form \code{A~W}, if specified this overrides the call to \code{SuperLearner}}
  \item{gbound}{value between (0,1) for truncation of predicted probabilities. See \code{Details} section for more information}
  \item{pZ1}{optional\eqn{nx2} matrix of conditional probabilities \eqn{P(Z=1|A=0,W), P(Z=1|A=1,W)}} 
  \item{g.Zform}{optional regression formula of the form \code{Z~A+W}, if specified this overrides the call to \code{SuperLearner}} 
  \item{pDelta1}{optional matrix of conditional probabilities for missingness mechanism, \eqn{nx2} when \code{Z} is \code{NULL} \eqn{P(Delta=1|A=0,W), P(Delta=1|A=1,W)}. \eqn{nx4} otherwise, \eqn{P(Delta=1|Z=0,A=0,W), P(Delta=1|Z=0,A=1,W), P(Delta=1|Z=1,A=0,W), P(Delta=1|Z=1,A=1,W)}}
  \item{g.Deltaform}{optional regression formula of the form \code{Delta~A+W}, if specified this overrides the call to \code{SuperLearner}}
  \item{g.SL.library}{optional vector of prediction algorithms to use for \code{SuperLearner} estimation of \code{g1W}}
\item{g.Delta.SL.library}{optional vector of prediction algorithms to use for \code{SuperLearner} estimation of \code{pDelta1} }
  \item{family}{family specification for working regression models, generally \sQuote{gaussian} for continuous outcomes (default), \sQuote{binomial} for binary outcomes}
  \item{fluctuation}{\sQuote{logistic} (default), or \sQuote{linear}}
  \item{alpha}{used to keep predicted initial values bounded away from (0,1) for logistic fluctuation}
  \item{id}{optional subject identifier}
  \item{V}{Number of cross-validation folds for estimating Q, and for super learner estimation of g}
  \item{verbose}{status messages printed if set to \code{TRUE} (default=\code{FALSE})}
  \item{Q.discreteSL}{if TRUE, discreteSL is used instead of ensemble SL. Ignored when SL not used to estimate Q} 
  \item{g.discreteSL}{if TRUE, discreteSL is used instead of ensemble SL. Ignored when SL not used to estimate g1W} 
  \item{g.Delta.discreteSL}{if TRUE, discreteSL is used instead of ensemble SL. Ignored when SL not used to estimate P(Delta = 1 | A,W,L)} 
  \item{prescreenW.g}{Screen covariates before estimating g in order to retain only those associated with Stage 1 residuals}
  \item{min.retain}{Minimum number of covariates to retain when prescreening covariates for g. Ignored when prescreenW.g=FALSE} 
  \item{RESID}{Flag indicating whether to retain covariates associated with the outcome \eqn{RESID=FALSE}, or associated only with the residuals from the outcome regression. Ignored when prescreenW.g=FALSE} 
  \item{target.gwt}{When TRUE, move g from denominator of clever covariate to the weight when fitting epsilon}
  \item{automate}{When TRUE, all tuning parameters are set to their default values. Number of cross validation folds and truncation level for g are set data-adaptively based on sample size (see details).}
}
\details{
 \code{gbounds} Lower bound defaults to lb = 5/sqrt(n)/log(n). For treatment effect estimates and population mean outcome the upper bound defaults to 1. For ATT and ATC, the upper bound defaults to 1- lb.

\code{W} may contain factors. These are converted to indicators via a call to \code{model.matrix}.

 Controlled direct effects are estimated when binary covariate \code{Z} is non-null. The tmle function returns an object of class \code{tmle.list}, a list of two items of class \code{tmle}.  The first corresponds to estimates obtained when \code{Z} is fixed at \eqn{0}, the second corresponds to estimates obtained when \code{Z} is fixed at \eqn{1}.

When automate = TRUE the sample size determines the number of cross validation folds, V: When \eqn{n <= 100}, V= 20; When \eqn{100 < n <=500} V=10; When \eqn{500 < n <= 1000} V=5; Otherwise V=3. Bounds on g set to (5/sqrt(n)/log(n), 1), except for ATT and ATE, where upper bound is 1-lower bound.
}
\value{
  \item{estimates}{list with elements EY1 (population mean), ATE (additive treatment effect), ATT (additive treatment effect among the treated), ATC (additive treatment effect among the controls), RR (relative risk), OR (odds ratio). Each element in the estimates of these is itself a list containing 
 \itemize{
  \item psi - parameter estimate 
  \item pvalue - two-sided p-value
  \item CI - 95\% confidence interval
  \item var.psi - Influence-curve based variance of estimate (ATE parameter only)
  \item log.psi - Parameter estimate on log scale (RR and OR parameters)
  \item var.log.psi - Influence-curve based variance of estimate on log scale (RR and OR parameters)
  }}
  \item{Qinit}{initial estimate of \code{Q}. \code{Qinit$coef} are the coefficients for a \code{glm} model for \code{Q}, if applicable.  \code{Qinit$Q} is an \eqn{nx2} matrix, where \code{n} is the number of observations.  Columns contain predicted values for \code{Q(0,W),Q(1,W)} using the initial fit.  \code{Qinit$type} is method for estimating \code{Q}. \code{Qinit$Rsq} is Rsq for initial estimate of Q. \code{Qinit$Rsq.type} empirical or cross-validated (depends on value of cvQinit), Rsq or pseudo-Rsq when Y is binary.}
  \item{Qstar}{targeted estimate of \code{Q}, an \eqn{nx2} matrix with predicted values for \code{Q(0,W), Q(1,W)} using the updated fit}
  \item{g}{treatment mechanism estimate. A list with four items: \code{g$g1W} contains estimates of \eqn{P(A=1|W)} for each observation, \code{g$coef} the coefficients for the model for \eqn{g} when \code{glm} used, \code{g$type} estimation procedure, \code{g$discreteSL} flag, \code{g$AUC} empirical AUC if ROCR package is available}
  \item{g.Z}{intermediate covariate assignment estimate (when applicable). A list with four items: \code{g.Z$g1W} an \eqn{nx2} matrix containing values of \eqn{P(Z=1|A=1,W), P(Z=1|A=0,W)} for each observation, \code{g.Z$coef} the coefficients for the model for \eqn{g} when \code{glm} used, \code{g.Z$type} estimation procedure, \code{g.Z$discreteSL} flag}
  \item{g.Delta}{missingness mechanism estimate. A list with four items: \code{g.Delta$g1W} an \eqn{nx4} matrix containing values of \eqn{P(Delta=1|Z,A,W)} for each observation, with (Z=0,A=0), (Z=0,A=1), (Z=1,A=0),(Z=1,A=1). (When \code{Z} is \code{NULL}, columns 3 and 4 are duplicates of 1 and 2.) \code{g.Delta$coef} the coefficients for the model for \eqn{g} when \code{glm} used, \code{g.Delta$type} estimation procedure, \code{g.Delta$discreteSL} flag}
  \item{gbound}{bounds used to truncate g}
  \item{gbound.ATT}{bounds used to truncated g for ATT and ATC estimation}
  \item{W.retained}{names of covariates used to model the components of g}
}
\references{
1. Gruber, S. and van der Laan, M.J. (2012), {tmle: An R Package for Targeted Maximum Likelihood Estimation}. \emph{Journal of Statistical Software}, 51(13), 1-35. \url{http://www.jstatsoft.org/v51/i13/}

2. Gruber, S. and van der Laan, M.J. (2009), {Targeted Maximum Likelihood Estimation: A Gentle Introduction}. \emph{U.C. Berkeley Division of Biostatistics Working Paper Series}.  Working Paper 252.  \url{http://www.bepress.com/ucbbiostat/paper252}

3. Gruber, S. and van der Laan, M.J.  (2010), {A Targeted Maximum Likelihood Estimator of a Causal Effect on a Bounded Continuous Outcome}. \emph{The International Journal of Biostatistics}, 6(1), 2010.

4. Rosenblum, M. and van der Laan, M.J. (2010).{Targeted Maximum Likelihood Estimation of the Parameter of a Marginal Structural Model}. \emph{The International Journal of Biostatistics}, 6(2), 2010.

5. van der Laan, M.J. and Rubin, D. (2006), {Targeted Maximum Likelihood Learning}. \emph{The International Journal of Biostatistics}, 2(1). \url{http://www.bepress.com/ijb/vol2/iss1/11/}

6. van der Laan, M.J., Rose, S., and Gruber,S., editors, (2009) {Readings in Targeted Maximum Likelihood Estimation} . \emph{U.C. Berkeley Division of Biostatistics Working Paper Series}.  Working Paper 254. \url{http://www.bepress.com/ucbbiostat/paper254}

7. van der Laan, M.J. and Gruber S. (2016), {One-Step Targeted Minimum Loss-based Estimation Based on Universal Least Favorable One-Dimensional Submodels}. \emph{The International Journal of Biostatistics}, 12 (1), 351-378.
}

\author{Susan Gruber \email{sgruber@cal.berkeley.edu}, in collaboration with Mark van der Laan.}


\seealso{
\code{\link{summary.tmle}},
\code{\link{estimateQ}},
\code{\link{estimateG}},
\code{\link{calcParameters}},
\code{\link{oneStepATT}},
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
\dontrun{
  result1 <- tmle(Y,A,W)
  summary(result1)
}
# Example 2: 
# User-supplied regression formulas to estimate Q and g
# binary outcome
  n <- 250
  W <- matrix(rnorm(n*3), ncol=3)
  colnames(W) <- paste("W",1:3, sep="")
  A <- rbinom(n,1, plogis(0.6*W[,1] +0.4*W[,2] + 0.5*W[,3]))
  Y <- rbinom(n,1, plogis(A + 0.2*W[,1] + 0.1*W[,2] + 0.2*W[,3]^2 ))
  result2 <- tmle(Y,A,W, family="binomial", Qform=Y~A+W1+W2+W3, gform=A~W1+W2+W3)
  summary(result2)

\dontrun{
# Example 3: Population mean outcome
# User-supplied (misspecified) model for Q, 
# Super learner called to estimate g, g.Delta
# V set to 2 for demo, not recommended at this sample size
# approx. 20% missing at random
  Y <- W[,1] + W[,2]^2 + rnorm(n)
  Delta <- rbinom(n, 1, 1/(1+exp(-(1.7-1*W[,1]))))
  result3 <- tmle(Y,A=NULL,W, Delta=Delta, Qform="Y~A+W1+W2+W3", V=2)
  print(result3)

# Example 4: Controlled direct effect
# User-supplied models for g, g.Z
# V set to 2 for demo, not recommended at this sample size
  A <- rbinom(n,1,.5)
  Z <- rbinom(n, 1, plogis(.5*A + .1*W[,1]))
  Y <- 1 + A + 10*Z + W[,1]+ rnorm(n)
  
  CDE <- tmle(Y,A,W, Z, gform="A~1", g.Zform = "Z ~ A + W1", V=2)
  print(CDE)
  total.effect <- tmle(Y,A, W,  gform="A~1")
  print(total.effect)
}
}
