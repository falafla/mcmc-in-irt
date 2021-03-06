## Set the seed to keep results reproducible 
set.seed(314159)

## Swap in the buggy log likelihood
log.prob.correct <- log.prob
log.prob         <- log.prob.buggy

## Make a buggy run
run.B.buggy <- run.chain.2pl(
    ## No burnin, keep 1000 iterations, do not thin
    M.burnin = 0, M.keep  = 1000, M.thin = 1,
    ## Use the fake data simulated in Post #2
    U.data  = U,
    ## Pass in the hyperpriors from Post #1
    hyperpars = hyperpars,
    ## Generate starting values uniformly from -5 to 5
    th.init = runif( length(theta.abl), 
                     min=-5, max=5     ),
    ## Set the other parameters to their true values 
    ## from Post #2
    a.init  = a.disc,
    b.init  = b.diff,
    s2.init = sig2.theta,
    MH.th=1, MH.a=NULL, MH.b=NULL, verbose=TRUE)

## Swap out the buggy sampler with the correct one
log.prob  <- log.prob.correct

## Convert to coda
run.B.buggy.mcmc <- mcmc( t(run.B.buggy) )
