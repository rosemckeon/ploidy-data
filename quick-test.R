rm(list=ls())
library(tidyverse)
library(devtools)
library(tictoc)
library(disturploidy)
message("TMPDIR: ", tempdir())

name <- "quick-test"
generations <- 5
simulations <- 4
runs <- 1

# saves a new data file for every run which contains
# the number of simulations specified. A separate
# logfile is stored for each simulation.
for(run in runs){
  this_run <- paste0(name, "-", run)
  disturploidy(
    pop_size = 250,
    grid_size = 10,
    pollen_range = 9,
    seed_dispersal_range = 9,
    ploidy_prob = .1,
    ploidy_growth_benefit = .5,
    inbreeding_cost = 0.5,
    selfing_polyploid_prob = 0.75,
    triploid_mum_prob = .2,
    disturbance_freq = 2,
    generations = generations,
    simulations = simulations,
    filename = this_run,
    logfilename = this_run
  )
}
