rm(list=ls())
library(tidyverse)
library(devtools)
library(tictoc)
library(disturploidy)

name <- "growth-benefit"
generations <- 200
simulations <- 1
runs <- 4

# saves a new data file for every run which contains
# the number of simulations specified. A separate
# logfile is stored for each simulation.
for(run in runs){

  this_run <- paste0(name, "_0.0_disturbance_000_", run)
  disturploidy(
    pop_size = 750,
    grid_size = 30,
    pollen_range = 29,
    seed_dispersal_range = 29,
    generations = generations,
    simulations = simulations,
    filename = this_run,
    logfilename = this_run,
    # turn on polyploids
    ploidy_prob = 0.01
  )

  this_run <- paste0(name, "_0.0_disturbance_010_", run)
  disturploidy(
    pop_size = 750,
    grid_size = 30,
    pollen_range = 29,
    seed_dispersal_range = 29,
    generations = generations,
    simulations = simulations,
    filename = this_run,
    logfilename = this_run,
    # turn on polyploids
    ploidy_prob = 0.01,
    # add disturbance
    disturbance_freq = 10
  )

  this_run <- paste0(name, "_0.0_disturbance_025_", run)
  disturploidy(
    pop_size = 750,
    grid_size = 30,
    pollen_range = 29,
    seed_dispersal_range = 29,
    generations = generations,
    simulations = simulations,
    filename = this_run,
    logfilename = this_run,
    # turn on polyploids
    ploidy_prob = 0.01,
    # add disturbance
    disturbance_freq = 25
  )

  this_run <- paste0(name, "_0.0_disturbance_050_", run)
  disturploidy(
    pop_size = 750,
    grid_size = 30,
    pollen_range = 29,
    seed_dispersal_range = 29,
    generations = generations,
    simulations = simulations,
    filename = this_run,
    logfilename = this_run,
    # turn on polyploids
    ploidy_prob = 0.01,
    # add disturbance
    disturbance_freq = 50
  )

  this_run <- paste0(name, "_0.0_disturbance_100_", run)
  disturploidy(
    pop_size = 750,
    grid_size = 30,
    pollen_range = 29,
    seed_dispersal_range = 29,
    generations = generations,
    simulations = simulations,
    filename = this_run,
    logfilename = this_run,
    # turn on polyploids
    ploidy_prob = 0.01,
    # add disturbance
    disturbance_freq = 100
  )

  this_run <- paste0(name, "_0.0_disturbance_002_", run)
  disturploidy(
    pop_size = 750,
    grid_size = 30,
    pollen_range = 29,
    seed_dispersal_range = 29,
    generations = generations,
    simulations = simulations,
    filename = this_run,
    logfilename = this_run,
    # turn on polyploids
    ploidy_prob = 0.01,
    # add disturbance
    disturbance_freq = 2
  )
}
