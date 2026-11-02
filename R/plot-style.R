# Warm Literary plotting system. Requires ggplot2 >= 4.0.0, ragg, systemfonts.
# Source this file, call wl_register_fonts(), then theme_set(theme_wl()).
.wl_source <- tryCatch(sys.frame(1)$ofile, error = function(e) NULL)
.wl_dir <- if (is.null(.wl_source)) getwd() else dirname(normalizePath(.wl_source))

wl_colours <- c(
  paper = "#FAF7F0", ink = "#302D2A", muted = "#72675F",
  rule = "#DED5C8", missing = "#BDB3A7", context = "#A69C90",
  burgundy = "#873B47", blue = "#365C7D", teal = "#36786B",
  ochre = "#A16B22", plum = "#79618B", graphite = "#5A6057"
)
wl_palette <- unname(wl_colours[c("burgundy", "blue", "ochre", "teal", "plum", "graphite")])
wl_shapes <- c(16, 17, 15, 18, 3, 8)
wl_linetypes <- c("solid", "22", "42", "13", "4313", "longdash")
wl_sequential <- c("#F1E8E5", "#D4B3B7", "#B47885", "#873B47", "#48202C")
wl_diverging <- c("#294F6B", "#91AFBC", "#FAF7F0", "#C38C94", "#873B47")

wl_register_fonts <- function(font_dir = file.path(.wl_dir, "fonts")) {
  if (!requireNamespace("systemfonts", quietly = TRUE)) stop("Install systemfonts.")
  paths <- file.path(font_dir, c("DM-Sans.ttf", "Source-Serif-4.ttf"))
  if (!all(file.exists(paths))) stop("Bundled fonts not found. Supply font_dir explicitly.")
  systemfonts::register_font("WL Sans", plain = paths[1])
  systemfonts::register_font("WL Serif", plain = paths[2])
  invisible(paths)
}

theme_wl <- function(base_size = 11, grid = c("y", "x", "both", "none"),
                     background = wl_colours[["paper"]],
                     base_family = "WL Sans", title_family = "WL Serif",
                     legend_position = "top") {
  if (utils::packageVersion("ggplot2") < "4.0.0") stop("theme_wl requires ggplot2 >= 4.0.0.")
  grid <- match.arg(grid)
  grid_line <- ggplot2::element_line(colour = wl_colours[["rule"]], linewidth = .3)
  ggplot2::theme_minimal(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      text = ggplot2::element_text(colour = wl_colours[["ink"]], lineheight = 1.15),
      geom = ggplot2::element_geom(ink = wl_colours[["burgundy"]],
                                  paper = background, accent = wl_colours[["blue"]]),
      plot.background = ggplot2::element_rect(fill = background, colour = NA),
      panel.background = ggplot2::element_rect(fill = background, colour = NA),
      panel.border = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major.x = if (grid %in% c("x", "both")) grid_line else ggplot2::element_blank(),
      panel.grid.major.y = if (grid %in% c("y", "both")) grid_line else ggplot2::element_blank(),
      axis.line = ggplot2::element_blank(), axis.ticks = ggplot2::element_blank(),
      axis.text = ggplot2::element_text(size = base_size * .88, colour = wl_colours[["muted"]]),
      axis.text.x = ggplot2::element_text(margin = ggplot2::margin(t = 7)),
      axis.text.y = ggplot2::element_text(margin = ggplot2::margin(r = 7)),
      axis.title = ggplot2::element_text(size = base_size * .93, colour = wl_colours[["muted"]]),
      axis.title.x = ggplot2::element_text(margin = ggplot2::margin(t = 11)),
      axis.title.y = ggplot2::element_text(margin = ggplot2::margin(r = 11)),
      plot.title = ggplot2::element_text(family = title_family, size = base_size * 1.65,
                                       face = "plain", margin = ggplot2::margin(b = 8)),
      plot.subtitle = ggplot2::element_text(size = base_size, colour = wl_colours[["muted"]],
                                          margin = ggplot2::margin(b = 15)),
      plot.caption = ggplot2::element_text(family = title_family, size = base_size * .85,
                                         colour = wl_colours[["muted"]], hjust = 0,
                                         margin = ggplot2::margin(t = 13)),
      plot.title.position = "plot", plot.caption.position = "plot",
      plot.margin = ggplot2::margin(19, 23, 17, 18),
      legend.position = legend_position, legend.justification = "left",
      legend.background = ggplot2::element_blank(),
      legend.key = ggplot2::element_blank(),
      legend.title = ggplot2::element_text(size = base_size * .9),
      legend.text = ggplot2::element_text(size = base_size * .88),
      legend.key.width = grid::unit(1.5, "lines"),
      legend.key.height = grid::unit(1.05, "lines"),
      legend.margin = ggplot2::margin(0, 0, 7, 0),
      strip.background = ggplot2::element_blank(),
      strip.text = ggplot2::element_text(size = base_size, hjust = 0,
                                        margin = ggplot2::margin(8, 0, 9, 0)),
      strip.placement = "outside", panel.spacing = grid::unit(1.3, "lines")
    )
}

# Use a named mapping whenever a category must keep its color across figures.
# Example: values = c(Control = wl_palette[2], Treatment = wl_palette[1]).
scale_colour_wl_d <- function(..., values = wl_palette, na.value = wl_colours[["missing"]]) {
  ggplot2::scale_colour_manual(..., values = values, na.value = na.value)
}
scale_color_wl_d <- scale_colour_wl_d
scale_fill_wl_d <- function(..., values = wl_palette, na.value = wl_colours[["missing"]]) {
  ggplot2::scale_fill_manual(..., values = values, na.value = na.value)
}
scale_shape_wl <- function(..., values = wl_shapes) {
  ggplot2::scale_shape_manual(..., values = values)
}
scale_linetype_wl <- function(..., values = wl_linetypes) {
  ggplot2::scale_linetype_manual(..., values = values)
}
scale_colour_wl_c <- function(..., diverging = FALSE, midpoint = 0,
                              na.value = wl_colours[["missing"]]) {
  if (diverging) {
    ggplot2::scale_colour_gradient2(..., low = wl_diverging[1], mid = wl_diverging[3],
      high = wl_diverging[5], midpoint = midpoint, na.value = na.value)
  } else ggplot2::scale_colour_gradientn(..., colours = wl_sequential, na.value = na.value)
}
scale_color_wl_c <- scale_colour_wl_c
scale_fill_wl_c <- function(..., diverging = FALSE, midpoint = 0,
                            na.value = wl_colours[["missing"]]) {
  if (diverging) {
    ggplot2::scale_fill_gradient2(..., low = wl_diverging[1], mid = wl_diverging[3],
      high = wl_diverging[5], midpoint = midpoint, na.value = na.value)
  } else ggplot2::scale_fill_gradientn(..., colours = wl_sequential, na.value = na.value)
}

# PNG exports use exact bundled fonts; no system font installation is required.
wl_save <- function(plot, filename, width = 7.2, height = 4.6, dpi = 200,
                    background = wl_colours[["paper"]]) {
  if (!requireNamespace("ragg", quietly = TRUE)) stop("Install ragg.")
  if (tolower(tools::file_ext(filename)) != "png") stop("wl_save currently exports PNG only.")
  ggplot2::ggsave(filename, plot = plot, device = ragg::agg_png,
                  width = width, height = height, units = "in", dpi = dpi,
                  bg = background, create.dir = TRUE)
  invisible(filename)
}

# Move the existing LEFT y-axis title above the panels, preserving its meaning.
# This is a rendering adapter: scale labels, data and facet layout are unchanged.
# NULL labels remain absent. Right-side y titles keep their native placement.
wl_editorial_grob <- function(plot) {
  plot <- plot + ggplot2::theme(plot.margin = ggplot2::margin(4, 5, 4, 0),
                               legend.margin = ggplot2::margin(0, 0, 7, 0))
  g <- ggplot2::ggplotGrob(plot)
  axis <- which(g$layout$name == "ylab-l")
  panels <- grep("^panel($|-)", g$layout$name)
  if (length(axis) != 1L || !length(panels)) return(g)
  native <- g$grobs[[axis]]
  if (!inherits(native, "titleGrob") || !length(native$children)) return(g)
  text <- native$children[[1]]
  if (is.null(text$label) || !length(text$label) || identical(text$label, "")) return(g)
  label <- grid::textGrob(text$label, x = grid::unit(0, "npc"),
    y = grid::unit(0.5, "npc"), hjust = 0, vjust = 0.5,
    gp = text$gp)
  title_columns <- seq(g$layout$l[axis], g$layout$r[axis])
  g$grobs[[axis]] <- grid::nullGrob()
  g$widths[title_columns] <- grid::unit(0, "pt")
  panel_top <- min(g$layout$t[panels])
  panel_left <- min(g$layout$l[panels])
  panel_right <- max(g$layout$r[panels])
  g <- gtable::gtable_add_rows(g, grid::grobHeight(label) + grid::unit(7, "pt"),
                               pos = panel_top - 1L)
  gtable::gtable_add_grob(g, label, t = panel_top, l = panel_left,
                         r = panel_right, clip = "off", name = "wl-y-title")
}

# Shared knitr renderer: authors print ordinary ggplots without a per-plot helper.
wl_knit_print <- function(x, options, ...) {
  if (inherits(x, "ggplot")) {
    grid::grid.newpage()
    grid::grid.draw(wl_editorial_grob(x))
    invisible(NULL)
  } else knitr::knit_print(x, options = options, ...)
}
