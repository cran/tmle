\name{tmle-package}
\Rdversion{2.0.0}
\alias{tmle-package}
\docType{package}
\title{Targeted Maximum Likelihood Estimation with Super Learning}
\description{
Targeted maximum likelihood estimation of marginal treatment effect of a binary point treatment on a continuous or binary outcome, adjusting for baseline covariates (ATE: entire population, ATT: treated population, ATC: control population). Missingness in the outcome is accounted for in the estimation procedure. The population mean outcome is calculated when there is missingness and no treatment.  Controlled direct effect estimation is available, and MSM parameter estimation for binary point treatment effects. Optional data-adaptive estimation of \emph{Q} and \emph{g} portions of the likelihood using the \code{SuperLearner} package is strongly encouraged.}
\author{
Susan Gruber, in collaboration with Mark van der Laan.

Maintainer: Susan Gruber, \email{sgruber@cal.berkeley.edu}
}
\references{
1. Gruber, S. and van der Laan, M.J. (2012), {tmle: An R Package for Targeted Maximum Likelihood Estimation}. \emph{Journal of Statistical Software}, 51(13), 1-35. \url{https://www.jstatsoft.org/v51/i13/}

2. Gruber, S. and van der Laan, M.J. (2009), {Targeted Maximum Likelihood Estimation: A Gentle Introduction}. \emph{U.C. Berkeley Division of Biostatistics Working Paper Series}.  Working Paper 252.  \url{https://biostats.bepress.com/ucbbiostat/paper252/}

3. Gruber, S. and van der Laan, M.J.  (2010), {A Targeted Maximum Likelihood Estimator of a Causal Effect on a Bounded Continuous Outcome}. \emph{The International Journal of Biostatistics}, 6(1), 2010.

4. Rosenblum, M. and van der Laan, M.J. (2010).{Targeted Maximum Likelihood Estimation of the Parameter of a Marginal Structural Model}. \emph{The International Journal of Biostatistics}, 6(2), 2010.

5. van der Laan, M.J. and Rubin, D. (2006), {Targeted Maximum Likelihood Learning}. \emph{The International Journal of Biostatistics}, 2(1).

6. van der Laan, M.J., Rose, S., and Gruber,S., editors, (2009) {Readings in Targeted Maximum Likelihood Estimation} . \emph{U.C. Berkeley Division of Biostatistics Working Paper Series}.  Working Paper 254. \url{https://biostats.bepress.com/ucbbiostat/paper254/}

7. van der Laan, M.J. and Gruber S. (2016), {One-Step Targeted Minimum Loss-based Estimation Based on Universal Least Favorable One-Dimensional Submodels}. \emph{The International Journal of Biostatistics}, 12 (1), 351-378.

8. Gruber, S., Phillips, R.V., Lee, H., van der Laan, M.J. Data-Adaptive Selection of the Propensity Score Truncation Level for Inverse Probability Weighted and Targeted Maximum Likelihood Estimators of Marginal Point Treatment Effects. \emph{American Journal of Epidemiology} 2022; 191(9), 1640-1651.
}

\seealso{
\code{\link{tmle}},
\code{\link{tmleMSM}}
}
