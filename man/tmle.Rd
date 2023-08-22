\name{tmle}
\alias{tmle}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Targeted Maximum Likelihood Estimation}
\description{
Targeted maximum likelihood estimation of parameters of a marginal structural model, and of marginal treatment effects of a binary point treatment on an outcome. In addition to the additive treatment effect, risk ratio and odds ratio estimates are reported for binary outcomes. The \code{tmle} function is generally called with arguments \code{(Y,A,W)}, where  \code{Y} is a continuous or binary outcome variable, \code{A} is a binary treatment variable, (\code{A=1} for treatment, \code{A=0} for control), and \code{W} is a matrix or dataframe of baseline covariates. The population mean outcome is calculated when there is no variation in \code{A}. If values of binary mediating variable \code{Z} are supplied, estimates are returned at each level of \code{Z}. Missingness in the outcome is accounted for in the estimation procedure if missingness indicator \code{Delta} is 0 for some observations.  Repeated measures can be identified using the \code{id} argument. Option to adjust for biased sampling using the \code{obsWeights} argument. Targeted bootstrap inference can be obtained in addition to IC-based inference by setting \code{B} to a value greater than 1 (10,000 recommended for analyses requiring high precision).}
\usage{
tmle(Y, A, W, Z=NULL, Delta = rep(1,length(Y)), Q = NULL, Q.Z1 = NULL, Qform = NULL, 
     Qbounds = NULL, Q.SL.library = c("SL.glm", "tmle.SL.dbarts2", "SL.glmnet"), 
     cvQinit = TRUE, g1W = NULL, gform = NULL, 
     gbound = NULL,  pZ1=NULL,
     g.Zform = NULL, pDelta1 = NULL, g.Deltaform = NULL, 
     g.SL.library = c("SL.glm", "tmle.SL.dbarts.k.5", "SL.gam"),
     g.Delta.SL.library =  c("SL.glm", "tmle.SL.dbarts.k.5", "SL.gam"),
     family = "gaussian", fluctuation = "logistic", alpha = 0.9995, id=1:length(Y), 
     V.Q = 10, V.g=10, V.Delta=10, V.Z = 10,
     verbose = FALSE, Q.discreteSL=FALSE, g.discreteSL=FALSE, g.Delta.discreteSL=FALSE,
     prescreenW.g=TRUE, min.retain = 5, target.gwt = TRUE, automate=FALSE,
     obsWeights = NULL, alpha.sig = 0.05, B = 1)
}
\arguments{
 \item{Y}{continuous or binary outcome variable}
  \item{A}{binary treatment indicator, \code{1} - treatment, \code{0} - control}
  \item{W}{vector, matrix, or dataframe containing baseline covariates}
  \item{Z}{optional binary indicator for intermediate covariate for controlled direct effect estimation}
  \item{Delta}{indicator of missing outcome or treatment assignment.  \code{1} - observed, \code{0} - missing}
  \item{Q}{optional \eqn{n \times 2} matrix of initial values for \eqn{Q} portion of the likelihood, \eqn{(E(Y|A=0,W), E(Y|A=1,W))}}
  \item{Q.Z1}{optional \eqn{n \times 2} matrix of initial values for \eqn{Q} portion of the likelihood, \eqn{(E(Y|Z=1,A=0,W), E(Y|Z=1,A=1,W))}. (When specified, values for \eqn{E(Y|Z=0,A=0,W), E(Y|Z=0,A=1,W)} are passed in using the \code{Q} argument}
 \item{Qform}{optional regression formula for estimation of \eqn{E(Y|A,W)}, suitable for call to \code{glm}}
  \item{Qbounds}{vector of upper and lower bounds on \code{Y} and predicted values for initial \code{Q}. Defaults to the range of \code{Y}, widened by 1\% of the min and max values.}
  \item{Q.SL.library}{optional vector of prediction algorithms to use for \code{SuperLearner} estimation of initial \code{Q}}
  \item{cvQinit}{logical, if \code{TRUE}, estimates cross-validated predicted values, default=\code{TRUE}}
  \item{g1W}{optional vector of conditional treatment assingment probabilities, \eqn{P(A=1|W)}}
  \item{gform}{optional regression formula of the form \code{A~W}, if specified this overrides the call to \code{SuperLearner}}
  \item{gbound}{value between (0,1) for truncation of predicted probabilities. See \code{Details} section for more information}
  \item{pZ1}{optional\eqn{n \times 2} matrix of conditional probabilities \eqn{P(Z=1|A=0,W), P(Z=1|A=1,W)}} 
  \item{g.Zform}{optional regression formula of the form \code{Z~A+W}, if specified this overrides the call to \code{SuperLearner}} 
  \item{pDelta1}{optional matrix of conditional probabilities for missingness mechanism, \eqn{n \times 2} when \code{Z} is \code{NULL} \eqn{P(Delta=1|A=0,W), P(Delta=1|A=1,W)}. \eqn{n \times 4} otherwise, \eqn{P(Delta=1|Z=0,A=0,W), P(Delta=1|Z=0,A=1,W), P(Delta=1|Z=1,A=0,W), P(Delta=1|Z=1,A=1,W)}}
  \item{g.Deltaform}{optional regression formula of the form \code{Delta~A+W}, if specified this overrides the call to \code{SuperLearner}}
  \item{g.SL.library}{optional vector of prediction algorithms to use for \code{SuperLearner} estimation of \code{g1W}}
\item{g.Delta.SL.library}{optional vector of prediction algorithms to use for \code{SuperLearner} estimation of \code{pDelta1} }
  \item{family}{family specification for working regression models, generally \sQuote{gaussian} for continuous outcomes (default), \sQuote{binomial} for binary outcomes}
  \item{fluctuation}{\sQuote{logistic} (default), or \sQuote{linear}}
  \item{alpha}{used to keep predicted initial values bounded away from (0,1) for logistic fluctuation}
  \item{id}{optional subject identifier}
  \item{V.Q}{Number of cross-validation folds for super learner estimation of Q}
  \item{V.g}{Number of cross-validation folds for super learner estimation of g}
  \item{V.Delta}{Number of cross-validation folds for super learner estimation of missingness mechanism}
  \item{V.Z}{Number of cross-validation folds for super learner estimation of intermediate variable}
  \item{verbose}{status messages printed if set to \code{TRUE} (default=\code{FALSE})}
  \item{Q.discreteSL}{if TRUE, discreteSL is used instead of ensemble SL. Ignored when SL not used to estimate Q} 
  \item{g.discreteSL}{if TRUE, discreteSL is used instead of ensemble SL. Ignored when SL not used to estimate g1W} 
  \item{g.Delta.discreteSL}{if TRUE, discreteSL is used instead of ensemble SL. Ignored when SL not used to estimate P(Delta = 1 | A,W)} 
  \item{prescreenW.g}{Option to screen covariates before estimating g in order to retain only those associated with the outcome (Recommend FALSE in low dimensional datasets)}
  \item{min.retain}{Minimum number of covariates to retain when prescreening covariates for g. Ignored when prescreenW.g=FALSE} 
  \item{target.gwt}{When TRUE, move g from denominator of clever covariate to the weight when fitting epsilon}
  \item{automate}{When TRUE, all tuning parameters are set to their default values. Number of cross validation folds, truncation level for g, and
decision to prescreen covariates for modeling g are set data-adaptively based on sample size (see details).}
  \item{obsWeights}{Optional observation weights to account for biased sampling}
  \item{alpha.sig}{significance level for constructing \code{1-alpha.sig} confidence intervals}
  \item{B}{Number of boostrap iterations. Set \eqn{B>1} to obtain targeted bootstrap based inference in addition to IC-based inference (see Details).}
}
\details{
 \code{gbounds} Lower bound defaults to lb = \eqn{5/sqrt(n)/log(n)}. For treatment effect estimates and population mean outcome the upper bound defaults to 1. For ATT and ATC, the upper bound defaults to 1- lb.

\code{W} may contain factors. These are converted to indicators via a call to \code{model.matrix}.

 Controlled direct effects are estimated when binary covariate \code{Z} is non-null. The tmle function returns an object of class \code{tmle.list}, a list of two items of class \code{tmle}.  The first corresponds to estimates obtained when \code{Z} is fixed at \eqn{0}, the second corresponds to estimates obtained when \code{Z} is fixed at \eqn{1}.

When automate = TRUE the sample size determines the number of cross validation folds, V based on the effective sample size. When Y is continuous n.effective = n. When Y is binary n.effective =  5 * size of minority class. When n.effective <= 30 V= n.effective; When n.effective <= 500 V= 20; When 500 < n <=1000 V=10; When 1000 < n <= 10000 V=5; Otherwise V=2. Bounds on \code{g} set to \eqn{(5/sqrt(n)/log(n), 1)}, except for ATT and ATE, where upper bound is 1-lower bound. \code{Wretain.g} set to TRUE when number of covariates \eqn{>= n.effective  / 5}.

 Set \code{B} = 10,000 to obtain high precision targeted bootstrap quantile-based confidence intervals and variance of bootstrap point estimates. Set \code{B} = 1,000 for rough approximation, and \code{B} = 1 for IC-based inference only.
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
  \item bs.var - Variance of bootstrap point estimates (when \code{B > 1})              
  \item bs.CI.twosided - Quantile-based 2-sided confidence interval bounds     
  \item bs.CI.onesided.lower - Quantile-based 1-sided lower confidence interval bounds
  \item bs.CI.onesided.upper - Quantile-based 1-sided upper confidence interval bounds
  }}
  \item{Qinit}{initial estimate of \code{Q}. \code{Qinit$coef} are the coefficients for a \code{glm} model for \code{Q}, if applicable.  \code{Qinit$Q} is an \eqn{n \times 2} matrix, where \code{n} is the number of observations.  Columns contain predicted values for \code{Q(0,W),Q(1,W)} using the initial fit.  \code{Qinit$type} is method for estimating \code{Q}. \code{Qinit$Rsq} is Rsq for initial estimate of Q. \code{Qinit$Rsq.type} empirical or cross-validated (depends on value of cvQinit), Rsq or pseudo-Rsq when Y is binary.}
  \item{Qstar}{targeted estimate of \code{Q}, an \eqn{n \times 2} matrix with predicted values for \code{Q(0,W), Q(1,W)} using the updated fit}
  \item{g}{treatment mechanism estimate. A list with four items: \code{g$g1W} contains estimates of \eqn{P(A=1|W)} for each observation, \code{g$coef} the coefficients for the model for \eqn{g} when \code{glm} used, \code{g$type} estimation procedure, \code{g$discreteSL} flag, \code{g$AUC} empirical AUC if ROCR package is available}
  \item{g.Z}{intermediate covariate assignment estimate (when applicable). A list with four items: \code{g.Z$g1W} an \eqn{n \times 2} matrix containing values of \eqn{P(Z=1|A=1,W), P(Z=1|A=0,W)} for each observation, \code{g.Z$coef} the coefficients for the model for \eqn{g} when \code{glm} used, \code{g.Z$type} estimation procedure, \code{g.Z$discreteSL} flag}
  \item{g.Delta}{missingness mechanism estimate. A list with four items: \code{g.Delta$g1W} an \eqn{n \times 4} matrix containing values of \eqn{P(Delta=1|Z,A,W)} for each observation, with (Z=0,A=0), (Z=0,A=1), (Z=1,A=0),(Z=1,A=1). (When \code{Z} is \code{NULL}, columns 3 and 4 are duplicates of 1 and 2.) \code{g.Delta$coef} the coefficients for the model for \eqn{g} when \code{glm} used, \code{g.Delta$type} estimation procedure, \code{g.Delta$discreteSL} flag}
  \item{gbound}{bounds used to truncate g}
  \item{gbound.ATT}{bounds used to truncated g for ATT and ATC estimation}
  \item{W.retained}{names of covariates used to model the components of g}
}
\references{
1. Gruber, S. and van der Laan, M.J. (2012), {tmle: An R Package for Targeted Maximum Likelihood Estimation}. \emph{Journal of Statistical Software}, 51(13), 1-35. \url{ https://www.jstatsoft.org/v51/i13/}

2. Gruber, S. and van der Laan, M.J. (2009), {Targeted Maximum Likelihood Estimation: A Gentle Introduction}. \emph{U.C. Berkeley Division of Biostatistics Working Paper Series}.  Working Paper 252.  \url{https://biostats.bepress.com/ucbbiostat/paper252/}

3. Gruber, S. and van der Laan, M.J.  (2010), {A Targeted Maximum Likelihood Estimator of a Causal Effect on a Bounded Continuous Outcome}. \emph{The International Journal of Biostatistics}, 6(1), 2010.

4. Rosenblum, M. and van der Laan, M.J. (2010).{Targeted Maximum Likelihood Estimation of the Parameter of a Marginal Structural Model}. \emph{The International Journal of Biostatistics}, 6(2), 2010.

5. van der Laan, M.J. and Rubin, D. (2006), {Targeted Maximum Likelihood Learning}. \emph{The International Journal of Biostatistics}, 2(1). \url{https://biostats.bepress.com/ucbbiostat/paper252/}

6. van der Laan, M.J., Rose, S., and Gruber,S., editors, (2009) {Readings in Targeted Maximum Likelihood Estimation} . \emph{U.C. Berkeley Division of Biostatistics Working Paper Series}.  Working Paper 254. \url{https://biostats.bepress.com/ucbbiostat/paper254/}

7. van der Laan, M.J. and Gruber S. (2016), {One-Step Targeted Minimum Loss-based Estimation Based on Universal Least Favorable One-Dimensional Submodels}. \emph{The International Journal of Biostatistics}, 12 (1), 351-378.

8. Gruber, S., Phillips, R.V., Lee, H., van der Laan, M.J. Data-Adaptive Selection of the Propensity Score Truncation Level for Inverse Probability Weighted and Targeted Maximum Likelihood Estimators of Marginal Point Treatment Effects. \emph{American Journal of Epidemiology} 2022; 191(9), 1640-1651.
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
  result2 <- tmle(Y,A,W, family="binomial", Qform="Y~A+W1+W2+W3", gform="A~W1+W2+W3")
  summary(result2)

\dontrun{
# Example 3:
# Incorporate sampling weights and
# request targeted bootstrap-based inference along with IC-based results
  pi <- .25 + .5*W[,1] > 0
  enroll <- sample(1:n, size = n/2, p = pi)
  result3 <- tmle(Y[enroll],A[enroll],W[enroll,], family="binomial", Qform="Y~A+W1+W2+W3",
             gform="A~W1+W2+W3", obsWeights = 1/pi[enroll],B=1000)
  summary(result3)

# Example 4: Population mean outcome
# User-supplied (misspecified) model for Q, 
# Super learner called to estimate g, g.Delta
# V set to 2 for demo, not recommended at this sample size
# approx. 20% missing at random
  Y <- W[,1] + W[,2]^2 + rnorm(n)
  Delta <- rbinom(n, 1, 1/(1+exp(-(1.7-1*W[,1]))))
  result4 <- tmle(Y,A=NULL,W, Delta=Delta, Qform="Y~A+W1+W2+W3", V.g=2, V.Delta=2)
  print(result4)

# Example 5: Controlled direct effect
# User-supplied models for g, g.Z
# V set to 2 for demo, not recommended at this sample size
  A <- rbinom(n,1,.5)
  Z <- rbinom(n, 1, plogis(.5*A + .1*W[,1]))
  Y <- 1 + A + 10*Z + W[,1]+ rnorm(n)
  
  CDE <- tmle(Y,A,W, Z, gform="A~1", g.Zform = "Z ~ A + W1", V.Q=2, V.g=2)
  print(CDE)
  total.effect <- tmle(Y,A, W,  gform="A~1")
  print(total.effect)
}
}
