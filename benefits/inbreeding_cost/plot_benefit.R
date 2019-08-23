rm(list=ls())
library(tidyverse)
theme_colors <- list(
  white = "#fafafa",
  orange = "#ec8216",
  orange_faded = "#d7c7b9",
  grey = "#d4d8d9",
  black = "#000000"
)

all_counts <- readRDS("benefits/inbreeding_cost/data/_counts_1.rds")

null <- all_counts %>%
  filter(dist_lvl == 0) %>%
  filter(inbreeding_cost == 1)

# Now make a useful plot
# of just the null result
null %>% ggplot(
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
    caption = "\nNow polyploids buffer the effects of inbreeding depression.\nThere is still no disturbance."
  )

# export plot as file
ggsave(
  paste0("inbreeding_ON-1.pdf"),
  path = "benefits/inbreeding_cost/plots", device = "pdf",
  width = 11.69, height = 8.27, units = "in",
  dpi = "retina",
  title = "Genetic Buffering Against Inbreeding"
)
