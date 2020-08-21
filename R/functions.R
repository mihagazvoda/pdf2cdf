plot_ecdf <- function(data_1, data_2) {
  req(data_1, data_2)

  plot_data <- bind_rows(
    mutate(data_1, n = "1"),
    mutate(data_2, n = "2")
  ) %>%
    group_by(n) %>%
    mutate(
      rel_val = drawn / sum(drawn),
      cs = cumsum(rel_val)
    )

  plot_data %>%
    ggplot(aes(x, cs, color = n)) +
    geom_line() +
    scale_color_manual(values = c("red", "blue")) +
    theme_light()
}
