rm(list=ls())
library(plyr)
library(tidyverse)
theme_colors <- list(
  white = "#fafafa",
  orange = "#ec8216",
  orange_faded = "#d7c7b9",
  grey = "#d4d8d9",
  black = "#000000"
)

name <- "matching"
cost_range <- c("0.000")
path <- "costs/uneven_matching_prob/"
dist_range <- c("000", "010")
pollen_range <- c("29")
run <- 1

# read in all the data files and combine tallies
all_counts <- NULL
for(val in cost_range){
  message("val: ", val)
  for(dist_lvl in dist_range){
    message("dist_lvl: ", dist_lvl)
    for(range in pollen_range){
      message("range: ", range)
      # get the data
      file <- paste0(
        path, "data/", name, "_", val,
        "_disturbance_", dist_lvl,
        "_pollen_", range,
        "_", run, ".rds"
      )
      message("file: ", file)
      break()
      sim <- readRDS(file)

      sim$data$adults
      # save the disturbances
      # disturbance <- sim$data$disturbance
      # overwrite full data with just adults
      sim <- sim$data$adults %>% select(gen, ploidy) %>%
        # give parameter cols for facets
        mutate(
          triploid_mum_prob = as.numeric(val),
          dist_lvl = as.numeric(dist_lvl),
          pollen_range = as.numeric(range)
        )
      # tally by grouping variable and keep in the new columns
      counts <- sim %>%
        group_by(gen, ploidy, triploid_mum_prob, dist_lvl, pollen_range) %>%
        tally()
      # clear memory
      sim <- NULL; gc(F)
      counts
      # combine dataframes
      all_counts <- bind_rows(all_counts, counts)
    }
  }
}

# Save all the counts
all_counts %>%
  saveRDS(paste0(path, "data/_counts_", run, ".rds"))

# Sort out facet labels so they're meaningful and properly ordered
# all_counts$growth_benefit <- all_counts$growth_benefit %>%
#   factor(levels(as.factor(all_counts$growth_benefit))[3:1])

# all_counts$dist_lvl <- all_counts$dist_lvl %>%
#   factor(levels(as.factor(all_counts$dist_lvl))[c(1, 4:2)]) %>%
#   revalue(
#     c(
#       "25" = 1/25,
#       "50" = 1/50,
#       "100" = 1/100
#     )
#   )


all_counts$ploidy = all_counts$ploidy %>%
  factor() %>%
  revalue(
    c(
      "2" = "Diploid",
      "3" = "Triploid",
      "4" = "Tetraploid"
    )
  )






# Save all the counts
# all_counts %>%
#   saveRDS(paste0(benefit_path, "data/_counts_", run, ".rds"))
