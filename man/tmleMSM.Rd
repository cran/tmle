\name{tmleMSM}
\Rdversion{1.4.0}
\alias{tmleMSM}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Targeted Maximum Likelihood Estimation of Parameter of MSM}
\description{
Targeted maximum likelihood estimation of the parameter of a marginal structural model (MSM) for binary point treatment effects. The \code{tmleMSM} function is minimally called with arguments \code{(Y,A,W, MSM)}, where  \code{Y} is a continuous or binary outcome variable, \code{A} is a binary treatment variable, (\code{A=1} for treatment, \code{A=0} for control), and \code{W} is a matrix or dataframe of baseline covariates. MSM is a valid regression formula for regressing \code{Y} on any combination of \code{A, V, W, T}, where \code{V} defines strata and \code{T} represents the time at which repeated measures on subjects are made.  Missingness in the outcome is accounted for in the estimation procedure if missingness indicator \code{Delta} is 0 for some observations.  Repeated measures can be identified using the \code{id} argument.}
\usage{
tmleMSM(Y, A, W, V, T = rep(1,length(Y)), Delta = rep(1, length(Y)), MSM, 
        v = NULL, Q = NULL, Qform = NULL, Qbounds = c(-Inf, Inf), 
        Q.SL.library = c("SL.glm", "tmle.SL.dbarts2", "SL.glmnet"), 
        cvQinit = TRUE, hAV = NULL, hAVform = NULL, g1W = NULL, 
        gform = NULL, pDelta1 = NULL, g.Deltaform = NULL, 
	g.SL.library = c("SL.glm", "tmle.SL.dbarts.k.5", "SL.gam"),
	ub = 1/0.025, family = "gaussian", fluctuation = "logistic", 
        alpha  = 0.995, id = 1:length(Y), V_SL = 5, inference = TRUE, 
        verbose = FALSE, Q.discreteSL = FALSE, g.discreteSL = FALSE) 
}
\arguments{
  \item{Y}{continuous or binary outcome variable}
  \item{A}{binary treatment indicator, \code{1} - treatment, \code{0} - control}
  \item{W}{vector, matrix, or dataframe containing baseline covariates. Factors are not currently allowed.}
  \item{V}{vector, matrix, or dataframe of covariates used to define strata}
  \item{T}{optional time for repeated measures data}
  \item{Delta}{indicator of missing outcome or treatment assignment.  \code{1} - observed, \code{0} - missing}
  \item{MSM}{MSM of interest, specified as valid right hand side of a regression formula (see examples)}
  \item{v}{optional value defining the strata of interest (\eqn{V=v}) for stratified estimation of MSM parameter}
  \item{Q}{optional \eqn{nx2} matrix of initial values for \eqn{Q} portion of the likelihood, \eqn{(E(Y|A=0,W), E(Y|A=1,W))}}
  \item{Qform}{optional regression formula for estimation of \eqn{E(Y|A, W)}, suitable for call to \code{glm}}
  \item{Qbounds}{vector of upper and lower bounds on \code{Y} and predicted values for initial \code{Q}}
  \item{Q.SL.library}{optional vector of prediction algorithms to use for \code{SuperLearner} estimation of initial \code{Q} }
  \item{cvQinit}{logical, if \code{TRUE}, estimates cross-validated predicted values using discrete super learning, default=\code{TRUE}}
  \item{hAV}{optional \eqn{nx2} matrix used in numerator of weights for updating covariate and the influence curve. If unspecified, defaults to conditional probabilities \eqn{P(A=1|V)} or \eqn{P(A=1|T)}, for repeated measures data. For unstabilized weights, pass in an \eqn{nx2} matrix of all 1s}
  \item{hAVform}{optionalregression formula of the form \code{A~V+T}, if specified this overrides the call to \code{SuperLearner}} 
  \item{g1W}{optional vector of conditional treatment assingment probabilities, \eqn{P(A=1|W)}}
  \item{gform}{optional regression formula of the form \code{A~W}, if specified this overrides the call to \code{SuperLearner}}
  \item{pDelta1}{optional \eqn{nx2} matrix of conditional probabilities for missingness mechanism,\eqn{P(Delta=1|A=0,V,W,T), P(Delta=1|A=1,V,W,T)}.} 
  \item{g.Deltaform}{optional regression formula of the form \code{Delta~A+W}, if specified this overrides the call to \code{SuperLearner}}
  \item{g.SL.library}{optional vector of prediction algorithms to use for \code{SuperLearner} estimation of \code{g1W} or \code{pDelta1} }
  \item{ub}{upper bound on observation weights. See \code{Details} section for more information}
  \item{family}{family specification for working regression models, generally \sQuote{gaussian} for continuous outcomes (default), \sQuote{binomial} for binary outcomes}
  \item{fluctuation}{\sQuote{logistic} (default), or \sQuote{linear}}
  \item{alpha}{used to keep predicted initial values bounded away from (0,1) for logistic fluctuation}
  \item{id}{optional subject identifier}
  \item{V_SL}{number of cross-validation folds for Super Learner estimation of Q and g}
  \item{inference}{if \code{TRUE}, variance-covariance matrix, standard errors, pvalues, and 95\% confidence intervals are calculated. Setting to FALSE saves a little time when bootstrapping.}
  \item{verbose}{status messages printed if set to \code{TRUE} (default=\code{FALSE})}
  \item{Q.discreteSL}{If true, use discrete SL to estimate Q, otherwise ensembleSL by default. Ignored when SL is not used.}
  \item{g.discreteSL}{If true, use discrete SL to estimate components of g, otherwise ensembleSL by default. Ignored when SL is not used.}
}
\details{
 \code{ub} bounds the IC by bounding the factor \eqn{h(A,V)/[g(A,V,W)P(Delta=1|A,V,W)]} between 0 and \code{ub}, default value = 1/0.025.
}
\value{
  \item{psi}{MSM parameter estimate} 
  \item{sigma}{variance covariance matrix}
  \item{se}{standard errors extracted from sigma}
  \item{pvalue}{two-sided p-value}
  \item{lb}{lower bound on 95\% confidence interval}
  \item{ub}{upper bound on 95\% confidence interval}
  \item{epsilon}{fitted value of epsilon used to target initial \code{Q}}
  \item{psi.Qinit}{MSM parameter estimate based on untargeted initial \code{Q}}
  \item{Qstar}{targeted estimate of \code{Q}, an \eqn{nx2} matrix with predicted values for \code{Q(0,W), Q(1,W)} using the updated fit}
  \item{Qinit}{initial estimate of \code{Q}. \code{Qinit$coef} are the coefficients for a \code{glm} model for \code{Q}, if applicable.  \code{Qinit$Q} is an \eqn{nx2} matrix, where \code{n} is the number of observations.  Columns contain predicted values for \code{Q(0,W),Q(1,W)} using the initial fit.  \code{Qinit$type} is method for estimating \code{Q}}
  \item{g}{treatment mechanism estimate. A list with three items: \code{g$g1W} contains estimates of \eqn{P(A=1|W)} for each observation, \code{g$coef} the coefficients for the model for \eqn{g} when \code{glm} used, \code{g$type} estimation procedure}
  \item{g.AV}{estimate for h(A,V) or h(A,T). A list with three items: \code{g.AV$g1W} an \eqn{nx2} matrix containing values of \eqn{P(A=0|V,T), P(A=1|V,T)} for each observation, \code{g.AV$coef} the coefficients for the model for \eqn{g} when \code{glm} used, \code{g.AV$type} estimation procedure}
  \item{g_Delta}{missingness mechanism estimate. A list with three items: \code{g_Delta$g1W} an \eqn{nx2} matrix containing values of \eqn{P(Delta=1|A,V,W,T)} for each observation, \code{g_Delta$coef} the coefficients for the model for \eqn{g} when \code{glm} used, \code{g_Delta$type} estimation procedure}
}
\references{
1. Gruber, S. and van der Laan, M.J. (2012), {tmle: An R Package for Targeted Maximum Likelihood Estimation}. \emph{Journal of Statistical Software}, 51(13), 1-35. \url{http://www.jstatsoft.org/v51/i13/}

2. Rosenblum, M. and van der Laan, M.J. (2010), {Targeted Maximum Likelihood Estimation of the Parameter of a Marginal Structural Model}. \emph{The International Journal of Biostatistics},6(2), 2010.
}

\author{Susan Gruber \email{sgruber@cal.berkeley.edu}, in collaboration with Mark van der Laan.}


\seealso{
\code{\link{summary.tmleMSM}},
\code{\link{estimateQ}},
\code{\link{estimateG}},
\code{\link{calcSigma}},
\code{\link{tmle}}
}
\examples{
library(tmle)
# Example 1. Estimating MSM parameter with correctly specified regression formulas
# MSM: psi0 + psi1*A + psi2*V + psi3*A*V  (saturated)
# true parameter value: psi = (0, 1, -2, 0.5) 
# generate data
  set.seed(100)
  n <- 1000
  W <- matrix(rnorm(n*3), ncol = 3)
  colnames(W) <- c("W1", "W2", "W3")
  V <- rbinom(n, 1, 0.5)
  A <- rbinom(n, 1, 0.5)
  Y <- rbinom(n, 1, plogis(A - 2*V + 0.5*A*V))
  result.ex1 <- tmleMSM(Y, A, W, V, MSM = "A*V", Qform = Y~., gform = A~1, 
                        hAVform = A~1, family = "binomial")
  print(result.ex1)
\dontrun{
# Example 2. Repeated measures data, two observations per id
# (e.g., crossover study design)
# MSM: psi0 + psi1*A + psi2*V + psi3*V^2 + psi4*T
# true parameter value: psi = (-2, 1, 0, -2, 0 )
# generate data in wide format (id,  W1, Y(t),  W2(t), V(t), A(t)) 
   set.seed(10)
   n <- 250
   id <- rep(1:n)
   W1   <- rbinom(n, 1, 0.5)
   W2.1 <- rnorm(n)
   W2.2 <- rnorm(n)  
   V.1   <- rnorm(n)  
   V.2   <- rnorm(n)
   A.1 <- rbinom(n, 1, plogis(0.5 + 0.3 * W2.1))
   A.2 <- 1-A.1
   Y.1  <- -2 + A.1 - 2*V.1^2 + W2.1 + rnorm(n)
   Y.2  <- -2 + A.2 - 2*V.2^2 + W2.2 + rnorm(n)
   d <- data.frame(id, W1, W2=W2.1, W2.2, V=V.1, V.2, A=A.1, A.2, Y=Y.1, Y.2)

# change dataset from wide to long format
   longd <- reshape(d, 
          varying = cbind(c(3, 5, 7, 9), c(4, 6, 8, 10)),
          idvar = "id",
          direction = "long",
          timevar = "T",
          new.row.names = NULL,
          sep = "")
# misspecified model for initial Q, partial misspecification for g. 
# V_SL set to 2 to save time, not recommended at this sample size
   result.ex2 <- tmleMSM(Y = longd$Y, A = longd$A, W = longd[,c("W1", "W2")], V = longd$V, 
          T = longd$T, MSM = "A + V + I(V^2) + T", Qform = Y ~ A + V, gform = A ~ W2, 
	id = longd$id, V_SL=2)
   print(result.ex2)


# Example 3:  Introduce 20% missingness in example 2 data
# V_SL set to 2 to save time, not recommended at this sample size
  Delta <- rbinom(nrow(longd), 1, 0.8)
  result.ex3 <- tmleMSM(Y = longd$Y, A = longd$A, W = longd[,c("W1", "W2")], V = longd$V, T=longd$T,
          Delta = Delta, MSM = "A + V + I(V^2) + T", Qform = Y ~ A + V, gform = A ~ W2,
	  g.Deltaform = Delta~ 1, id=longd$id, verbose = TRUE, V_SL=2)
  print(result.ex3)
}
}
