# Load packages -----

library(brandr)
library(ggplot2)
library(here)
library(magrittr)
library(ragg)
library(systemfonts)

# Set options -----

options(scipen = 999)

# Set `brandr` -----

options(BRANDR_BRAND_YML = here("_brand.yml"))

brandr_options <- list(
  "BRANDR_COLOR_SEQUENTIAL" = get_brand_color(c("primary", "tertiary")),
  "BRANDR_COLOR_DIVERGING" = get_brand_color(c("primary", "white", "tertiary")),
  "BRANDR_COLOR_QUALITATIVE" = c(
    get_brand_color("primary"),
    get_brand_color("secondary"),
    get_brand_color("tertiary"),
    get_brand_color("black")
  )
)

for (i in seq_along(brandr_options)) {
  options(brandr_options[i])
}

# Set `systemfonts` -----

clear_registry()

register_font(
  name = "poppins",
  plain = here("fonts", "poppins-regular.ttf"),
  bold = here("fonts", "poppins-bold.ttf"),
  italic = here("fonts", "poppins-italic.ttf"),
  bolditalic = here("fonts", "poppins-bolditalic.ttf")
)

# registry_fonts()

# Set `ggplot2` -----

theme_set(
  theme_bw() +
    theme(
      text = element_text(
        color = get_brand_color("black"),
        family = "poppins",
        face = "plain"
      ),
      panel.background = element_rect(fill = "transparent"),
      plot.background = element_rect(
        fill = "transparent",
        color = NA
      ),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.background = element_rect(fill = "transparent"),
      legend.box.background = element_rect(
        fill = "transparent",
        color = NA
      ),
      legend.frame = element_blank()
    )
)
