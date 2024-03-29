rm(list=ls())
library(tidyverse)
theme_colors <- list(
  white = "#fafafa",
  orange = "#ec8216",
  orange_faded = "#d7c7b9",
  grey = "#d4d8d9",
  black = "#000000"
)

all_counts <- readRDS("benefits/ploidy_growth_benefit/data/_counts_4.rds")

all_counts <- all_counts %>%
  filter(growth_benefit != 0)

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
  facet_grid(growth_benefit ~ dist_lvl) +
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
    caption = "Disturbance is shown left to right; weak to strong.\n Ploidy growth benefit is shown bottom to top; weak to strong."
  )

# export plot as file
ggsave(
  paste0("growth-benefit_4b.pdf"),
  path = "benefits/ploidy_growth_benefit/plots/", device = "pdf",
  width = 11.69, height = 8.27, units = "in",
  dpi = "retina",
  title = "Polyploid Gigas Effects and Disturbance"
)
