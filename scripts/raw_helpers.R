# Dependencies ------------------------------------------------------------

requireNamespace("dplyr")
requireNamespace("knitr")
requireNamespace("tidyr")
requireNamespace("ggplot2")
`%>%` <- dplyr::`%>%`

# Utilities ---------------------------------------------------------------

count_not_na <- function(vec) {
  sum(!is.na(vec))
}

# Annotation --------------------------------------------------------------

summarize_annotation <- function(tbl) {
  tbl %>%
    dplyr::summarize(
      num_ann = count_not_na(mnx_id),
      num_namespaces = na.omit(prefix) %>% dplyr::n_distinct()
    ) %>%
    knitr::kable(
      format.args = list(big.mark = ","),
      col.names = c(
        "Identifiers",
        "Unique Namespaces"
      ),
      caption = "Overall number of identifiers and of unique source namespaces."
    )
}

summarize_annotation_sources <- function(tbl) {
  tbl %>%
    dplyr::select(prefix) %>%
    tidyr::drop_na(prefix) %>%
    dplyr::count(prefix) %>%
    dplyr::arrange(prefix) %>%
    knitr::kable(
      format.args = list(big.mark = ","),
      col.names = c("Namespace", "Frequency"),
      caption = "Number of identifiers per source namespace."
    )
}

annotation_per_element <- function(tbl) {
  tbl %>%
    tidyr::drop_na(identifier) %>%
    dplyr::group_by(mnx_id) %>%
    dplyr::summarize(
      num_ann = dplyr::n_distinct(identifier),
      num_prefix = dplyr::n_distinct(prefix)
    ) %>%
    dplyr::ungroup() %>%
    dplyr::collect()
}

plot_annotation <- function(tbl) {
  tbl %>%
    tidyr::pivot_longer(!mnx_id) %>%
    dplyr::mutate(
      name = forcats::fct_recode(name,
        "Namespaces" = "num_prefix",
        "Identifiers" = "num_ann"
      )
    ) %>%
    ggplot2::ggplot(ggplot2::aes(x = value)) +
    ggplot2::geom_freqpoly(stat = "count", show.legend = FALSE) +
    ggplot2::geom_boxplot(show.legend = FALSE) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab("Number") +
    ggplot2::scale_x_log10() +
    ggplot2::scale_y_log10() +
    ggplot2::facet_grid(. ~ name, scales = "free")
}

# Deprecated --------------------------------------------------------------

summarize_deprecated <- function(tbl) {
  tbl %>%
    dplyr::summarise(
      num = na.omit(current_id) %>% dplyr::n_distinct(),
      num_deprecated = na.omit(deprecated_id) %>% dplyr::n_distinct(),
    ) %>%
    knitr::kable(
      col.names = c(
        "Number of Current",
        "Number of Deprecated"
      ),
      caption = "The total number of current identifiers with deprecated identifiers."
    )
}
