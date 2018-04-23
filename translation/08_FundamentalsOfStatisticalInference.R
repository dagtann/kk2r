rm(list = ls())
## Random samples and sampling distributions ===============

### How to generate random numbers =========================
runif(1)

set.seed(42)
runif(1)

runif(1)

# Create integer in the open interval (0, 6)
6 * runif(1)
# From the help file: "runif will not generate either of the
# extreme values unless max = min or max-min is small
# compared to min, and in particular not for the default
# arguments".

1 + as.integer(6 * runif(1))
# Returns an integer on the interval [1, 6]. Values on the
# arbitrary interval (a, b) can be created using
# a + (b - a) * r where r is a random draw from a uniform
# distribution on the unit interval.

a <- 6; b <- 23; a + (b - a) * runif(1)

# In R you could of course just
runif(1, a, b)

### How to create fictitious data ==========================

n <- 1000 # fix sample size
x1 <- as.integer(runif(n, 1, 6)) # random integers from (1, 6)

table(x1)
prop.table(table(x1))

beta_parameters <- matrix(
  c(
    1, 1, # uniform
    .5, .5, # u-shaped
    1, 3, # decreasing
    5, 1, # increasing
    2, 5, # positive skew
    5, 2 # negative skew
  ),
  ncol = 2, byrow = TRUE
)
plot(
  c(0, 1), c(0, 3), type = 'n',
  ylab = 'Density', xlab = "Value of generated variable"
)
for(i in 1:nrow(beta_parameters)){
  curve(
    dbeta(x, beta_parameters[i, 1], beta_parameters[i, 2]),
    from = 0, to = 1, add = TRUE, lty = i
  )
}
legend(
  x = 'top', lty = 1:nrow(beta_parameters), bty = 'n',
  legend = paste0(
    'dbeta(',
      beta_parameters[, 1], ', ', beta_parameters[, 2],
    ')'
  )
)

# Generate a random normal deviate from runif().
x2 <- qnorm(runif(n))
plot(density(x2)); abline(v = 0)

x3 <- rnorm(n); x4 <- rnorm(n, 2); x5 <- rnorm(n, 0, 2)
plot(density(x3), xlim = c(-5, 10))
lines(density(x4), lty = 2)
lines(density(x5), lty = 3)

# Now generate two systematically related random variables.
men <- as.integer(runif(n) * 2)
# Alternatively, you could sample(0:1, n, replace = TRUE).
income <- ifelse(
  1 != men, rnorm(n, 10e3, 15e3), rnorm(n, 20e3, 40e3)
)
by(data = income, INDICES = men, FUN = summary)
by(data = income, INDICES = men, FUN = sd)
# Note that men and women differ on mean and variance.
# To keep variances equal b/w the groups you could:
b <- 10e3 # difference b/w genders
income <- rnorm(n, 20e3, 40e3) + b * men
by(data = income, INDICES = men, FUN = summary)
by(data = income, INDICES = men, FUN = sd)

### Create simple random samples
library("foreign")
berlin <- read.dta("/Users/dag/github/kohler/kk/berlin.dta")
str(berlin)
summary(berlin[, 'ybirth']); nrow(berlin)

rel_size_sample <- .1
N <- nrow(berlin)
berlin_s1 <- sample(
  1:N, size = ceiling(rel_size_sample * N),
  replace = FALSE
)
berlin_s1 <- berlin[berlin_s1, ]
summary(berlin_s1); length(berlin_s1)

# using runif
berlin[, 'select_obs'] <- runif(N) <= .001
berlin_s2 <- subset(berlin, select_obs == 1)
summary(berlin_s2)

### Sampling distribution
n_sims <- 500
smplmeans <- vector(length = n_sims, 'numeric')
for(i in 1:n_sims){
  selected_obs <- sample(
    1:nrow(berlin), size = 100, replace = FALSE
  )
  smplmeans[i] <- mean(berlin[selected_obs, 'ybirth'])
}
summary(smplmeans)
sigma <- sd(smplmeans)
mu <- mean(smplmeans)
plot(density(smplmeans))
abline(
  v = c(mu - sigma, mu, mu + sigma),
  lty = c('dashed', 'solid', 'dashed')
)

limit <- ifelse(
  mu - sigma < smplmeans & smplmeans < mu + sigma, 1, 0)
table(limit); mean(limit)

outer(c(2, 1), c(-1, 1), sigma)