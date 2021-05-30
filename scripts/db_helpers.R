# Dependencies ------------------------------------------------------------

requireNamespace("dplyr")
requireNamespace("knitr")
requireNamespace("tidyr")
requireNamespace("ggplot2")
`%>%` <- dplyr::`%>%`

# Annotation --------------------------------------------------------------

summarize_annotation <- function(tbl) {
  tbl %>%
    dplyr::summarize(
      num_ann = COUNT(id),
      num_namespaces = dplyr::n_distinct(prefix)
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
    dplyr::count(prefix) %>%
    dplyr::arrange(prefix) %>%
    knitr::kable(
      format.args = list(big.mark = ","),
      col.names = c("Namespace", "Frequency"),
      caption = "Number of identifiers per source namespace. Identifiers are deduplicated compared to raw tables."
    )
}

plot_annotation <- function(tbl) {
  tbl %>%
    dplyr::group_by(id) %>%
    dplyr::summarize(
      num_ann = dplyr::n_distinct(identifier),
      num_prefix = dplyr::n_distinct(prefix)
    ) %>%
    dplyr::ungroup() %>%
    dplyr::collect() %>%
    tidyr::pivot_longer(!id) %>%
    dplyr::mutate(
      name = forcats::fct_recode(name,
        "Namespaces" = "num_prefix",
        "Identifiers" = "num_ann"
      )
    ) %>%
    ggplot2::ggplot(ggplot2::aes(x = name, y = value)) +
    ggplot2::geom_boxplot(show.legend = FALSE) +
    ggplot2::geom_violin(scale = "width", alpha = 0, show.legend = FALSE) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab("Number")
}

# Names -------------------------------------------------------------------

summarize_names <- function(tbl) {
  tbl %>%
    dplyr::summarize(
      num_comps = COUNT(id),
      num_namespaces = dplyr::n_distinct(prefix)
    ) %>%
    knitr::kable(
      format.args = list(big.mark = ","),
      col.names = c(
        "Names",
        "Unique Namespaces"
      ),
      caption = "Overall number of names and of unique source namespaces."
    )
}

summarize_name_sources <- function(tbl) {
  tbl %>%
    dplyr::select(prefix) %>%
    dplyr::count(prefix) %>%
    dplyr::arrange(prefix) %>%
    knitr::kable(
      format.args = list(big.mark = ","),
      col.names = c("Namespace", "Frequency"),
      caption = "Number of names per source namespace. Names are deduplicated compared to raw tables."
    )
}

plot_names <- function(tbl) {
  tbl %>%
    dplyr::group_by(id) %>%
    dplyr::summarise(
      num_name = dplyr::n_distinct(name),
      num_prefix = dplyr::n_distinct(prefix)
    ) %>%
    dplyr::ungroup() %>%
    dplyr::collect() %>%
    tidyr::pivot_longer(!id) %>%
    dplyr::mutate(
      name = forcats::fct_recode(name,
        "Namespaces" = "num_prefix",
        "Names" = "num_name"
      )
    ) %>%
    ggplot2::ggplot(ggplot2::aes(x = name, y = value)) +
    ggplot2::geom_boxplot(show.legend = FALSE) +
    ggplot2::geom_violin(scale = "width", alpha = 0, show.legend = FALSE) +
    ggplot2::xlab(NULL) +
    ggplot2::ylab("Number")
}
