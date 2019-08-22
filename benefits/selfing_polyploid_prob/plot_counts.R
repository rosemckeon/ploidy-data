rm(list=ls())
library(tidyverse)
library(plyr)
theme_colors <- list(
  white = "#fafafa",
  orange = "#ec8216",
  orange_faded = "#d7c7b9",
  grey = "#d4d8d9",
  black = "#000000"
)

all_counts <- NULL

benefit_name <- "selfing"
benefit_path <- "benefits/selfing_polyploid_prob/"
benefit_range <- c("0.0", "1.0")
dist_range <- c("000", "100", "025", "010")
#pollen_range <- c("29")
run <- 1

# read in all the data files and combine tallies
for(benefit_val in benefit_range){
  message("benefit_val: ", benefit_val)
  for(dist_lvl in dist_range){
    message("dist_lvl: ", dist_lvl)
    # get the data
    sim <- paste0(
      benefit_path, "data/", benefit_name, "_", benefit_val, "_",
      "disturbance_", dist_lvl, "_pollen_29_", run, ".rds"
    ) %>%
      readRDS()
    # save the disturbances
    disturbance <- sim$data$disturbance
    # overwrite full data with just adults
    sim <- sim$data$adults %>% select(gen, ploidy) %>%
      # give parameter cols for facets
      mutate(
        selfing_prob = as.numeric(benefit_val),
        dist_lvl = as.numeric(dist_lvl)
      )
     # tally by grouping variable and keep in the new columns
    counts <- sim %>%
      group_by(gen, ploidy, selfing_prob, dist_lvl) %>%
      tally()
    # clear memory
    sim <- NULL; gc(F)
    # combine dataframes
    all_counts <- bind_rows(all_counts, counts)
  }
}
# Save all the counts
all_counts %>%
  saveRDS(paste0(benefit_path, "data/_counts_", run, ".rds"))

# Sort out facet labels so they're meaningful and properly ordered
all_counts$selfing_prob <- all_counts$selfing_prob %>%
  factor(levels(as.factor(all_counts$selfing_prob))[3:1])

all_counts$dist_lvl <- all_counts$dist_lvl %>%
  factor(levels(as.factor(all_counts$dist_lvl))[c(1, 4:2)]) %>%
  revalue(
    c(
      "10" = 1/10,
      "25" = 1/25,
      "100" = 1/100
    )
  )

all_counts$ploidy = all_counts$ploidy %>%
  factor() %>%
  revalue(
    c(
      "2" = "Diploid",
      "3" = "Triploid",
      "4" = "Tetraploid"
    )
  )

# Now make a useful facet plot
all_counts %>% ggplot(
  mapping = aes(
    x = gen,
    y = n,
    fill = ploidy,
    colour = ploidy
  )
) +
  theme_classic() +
  xlab("Time (generations)") +
  ylab("Population size (N)") +
  geom_area() +
  facet_grid(selfing_prob ~ dist_lvl) +
  scale_colour_manual(
    name = "",
    values = c(
      theme_colors$black,
      theme_colors$orange_faded,
      theme_colors$orange
      )
  )  +
  scale_fill_manual(
    name = "",
    values = c(
      theme_colors$black,
      theme_colors$orange_faded,
      theme_colors$orange
    )
  ) +
  scale_x_continuous(breaks = c(0, 100, 200)) +
  scale_y_continuous(breaks = c(0, 450, 900)) +
  theme(
    legend.position = "top",
    legend.background = element_rect(
      fill = "#fafafa"
    ),
    strip.background = element_rect(
      colour = "#d4d8d9",
      fill = "#d4d8d9"
    ),
    strip.text.x = element_text(
      face = "bold"
    ),
    strip.text.y = element_text(
      face = "bold"
    ),
    plot.background = element_rect(
      fill = "#fafafa"
    )
  ) +
  labs(
    caption = "Disturbance is shown left to right; weak to strong.\n Cost of inbreeding is shown bottom to top; weak to strong."
  )

# export plot as file
ggsave(
  paste0(benefit_name, "_mate-choice-high", run, ".pdf"),
  path = paste0(benefit_path, "plots"), device = "pdf",
  width = 11.69, height = 8.27, units = "in",
  dpi = "retina",
  title = "Reversal of Selfing Inhibition and Disturbance"
)

# Save all the counts again
all_counts %>%
  saveRDS(paste0(benefit_path, "data/_counts_", run, ".rds"))
