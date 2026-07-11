library(here)

source(here("R", ".setup.R"))

library(checkmate)
library(cli)
library(ggplot2)
library(here)
library(magick)
library(ragg)

plot_animated_data <- function(
  year = 1951,
  months = 3,
  text_size = 18,
  width = 1000,
  height = 300,
  file_name = here("images", "worldclim-animation-2.gif")
) {
  assert_number(year, lower = 1951, upper = 2024)
  assert_number(months, lower = 1, upper = 12)
  assert_number(text_size, lower = 1)
  assert_number(width, lower = 100)
  assert_number(height, lower = 100)
  assert_string(file_name)

  files <- character()

  for (i in seq_len(months)) {
    i_plot <- plot_data(year = year, month = i, text_size = text_size)
    i_file <- tempfile()

    ggsave(
      filename = i_file,
      plot = i_plot,
      device = agg_png,
      width = width,
      height = height,
      units = "px",
      dpi = 150,
    )

    files <- files |> append(i_file)
  }

  animation <-
    files |>
    lapply(image_read) |>
    image_join() |>
    image_animate(fps = 1)

  animation |> image_write(file_name)

  invisible(animation)
}

library(brandr)
library(checkmate)
library(dplyr)
library(geodata)
library(here)
library(patchwork)
library(stringr)
library(terra)

# # Helpers -----
#
# gadm(country = "bra", level = 2, path = tempdir()) %>%
#   subset(., !.$NAME_2 %in% c("Fernando de Noronha")) |>
#   terra::ext()

plot_data <- function(year = 1951, month = 1, text_size = 8) {
  assert_number(year, lower = 1951, upper = 2024)
  assert_number(month, lower = 1, upper = 12)
  assert_number(text_size, lower = 1)

  month <- str_pad(month, width = 2, pad = "0")

  brazil_shape <-
    gadm(country = "bra", level = 0, path = here("data-raw")) |>
    crop(c(-73.99044997, -34.793056, -33.75114991, 5.27184108))

  logonia_box <- c(-63.5, -55, -7.5, 0)

  logonia_box_shape <- vect(
    rbind(
      c(logonia_box[1], logonia_box[3]),
      c(logonia_box[2], logonia_box[3]),
      c(logonia_box[2], logonia_box[4]),
      c(logonia_box[1], logonia_box[4]),
      c(logonia_box[1], logonia_box[3])
    ),
    type = "polygons",
    crs = "EPSG:4326"
  )

  for (i in c("tmin", "tmax", "prec")) {
    here(
      "data",
      "historical-monthly-weather-data",
      paste0(
        "wc2.1_cruts4.09_10m_",
        i,
        "_",
        year,
        "-",
        month,
        ".asc"
      )
    ) |>
      rast() |>
      crop(logonia_box_shape) |>
      assign(x = paste0(i, "_data"), value = _)
  }

  brazil_plot <- plot_brazil(
    brazil_shape,
    logonia_box_shape,
    title = paste0(year, "-", month),
    text_size = text_size
  )

  tmin_plot <- plot_worldclim(tmin_data, "tmin", "A", text_size)
  tmax_plot <- plot_worldclim(tmax_data, "tmax", "B", text_size)
  prec_plot <- plot_worldclim(prec_data, "prec", "C", text_size)

  patchwork::wrap_plots(
    brazil_plot,
    tmin_plot,
    tmax_plot,
    prec_plot,
    ncol = 2,
    nrow = 2,
    # widths = 1,
    # heights = 1,
    axis_titles = "collect"
  )

  prec_plot
}

library(checkmate)
library(ggplot2)
library(stringr)
library(terra)
library(tidyterra)

plot_brazil <- function(
  brazil_shape,
  logonia_box_shape,
  title = "1951-01",
  text_size = 8
) {
  assert_class(brazil_shape, "SpatVector")
  assert_class(logonia_box_shape, "SpatVector")
  assert_string(title)
  assert_number(text_size, lower = 1)

  ggplot() +
    geom_spatvector(
      data = brazil_shape,
      color = get_brand_color("gray"),
    ) +
    geom_spatvector(
      data = logonia_box_shape,
      color = get_brand_color("brown"),
      # fill = get_brand_color("brown"),
      linewidth = 0.5,
      alpha = 0.75
    ) +
    labs(title = NULL) +
    theme_void()
}

library(checkmate)
library(colorspace)
library(dplyr)
library(ggplot2)
library(terra)
library(tidyterra)

plot_worldclim <- function(raster, var = "tmin", title = "A", text_size = 8) {
  assert_class(raster, "SpatRaster")
  assert_choice(var, choices = c("tmin", "tmax", "prec"))
  assert_string(title)
  assert_number(text_size, lower = 1)

  color <- case_match(
    var,
    "tmin" ~ get_brand_color("lime"),
    "tmax" ~ get_brand_color("olive-brown"),
    "prec" ~ get_brand_color("brown")
  )

  ggplot() +
    geom_spatraster(data = raster) +
    scale_fill_steps2(
      low = get_brand_color("black"),
      mid = color,
      high = get_brand_color("white"),
      midpoint = raster |> as.vector() |> mean(na.rm = TRUE)
    ) +
    labs(title = NULL, fill = NULL) +
    theme_void() +
    theme(
      legend.position = "none"
    )
}
