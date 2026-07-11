library(here)

source(here("R", ".setup.R"))

library(checkmate)
library(ggplot2)
library(glue)
library(here)
library(ragg)

plot_sigmoid <- function(
  intercept_range = seq(-235, -197.5, by = 1),
  coefficients = c(tmin = 0.35, tmax = 0.45, prec = 1),
  values = c(tmin = 22.32, tmax = 31.22, prec = 194.61),
  text_size = 12,
  width = 600,
  height = 400,
  file_name = here("images", "logistic-regression-sigmoid.png")
) {
  assert_numeric(intercept_range)
  assert_numeric(coefficients, len = 3)
  assert_numeric(values, len = 3)
  assert_number(text_size, lower = 8, upper = 20)
  assert_number(width, lower = 100)
  assert_number(height, lower = 100)
  assert_string(file_name)

  prob <- numeric()

  for (i in intercept_range) {
    i_prob <- logistic_regression(
      intercept = i,
      coefficients = coefficients,
      values = values
    )

    prob <- c(prob, i_prob)
  }

  plot <-
    ggplot(mapping = aes(x = intercept_range, y = prob)) +
    geom_line(
      color = get_brand_color("lime"),
      linewidth = 0.75
    ) +
    labs(
      x = "Intercept",
      y = "Probability",
      subtitle = glue(
        "Coefficients: ",
        "tmin = {coefficients['tmin']}",
        ", ",
        "tmax = {coefficients['tmax']}",
        ", ",
        "prec = {coefficients['prec']}",
        "\n",
        "Values: ",
        "tmin = {values['tmin']}",
        ", ",
        "tmax = {values['tmax']}",
        ", ",
        "prec = {values['prec']}",
      )
    ) +
    theme_bw() +
    theme(
      text = element_text(size = text_size),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank()
    )

  ggsave(
    filename = file_name,
    plot = plot,
    device = agg_png,
    width = width,
    height = height,
    units = "px",
    dpi = 150
  )

  plot
}

library(checkmate)

logistic_regression <- function(intercept, coefficients, values) {
  assert_number(intercept)
  assert_numeric(coefficients, len = 3)
  assert_numeric(values, len = 3)

  linear_combination <- intercept + sum(values * coefficients)

  1 / (1 + exp(-linear_combination))
}
