



time_conversion_h_to_m <- function(hrs_dep_delay, dat = mega_data) {
  hrs_dep_delay = (mega_data$dep_delay / 60)
  q4plot <- ggplot(mega_data, aes(x = carrier, y = hrs_dep_delay, fill = carrier)) +
    geom_boxplot() +
    scale_color_viridis_d() +
    theme_classic()
  return(q4plot)
}
