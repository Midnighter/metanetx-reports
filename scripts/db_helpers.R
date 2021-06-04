# Dependencies ------------------------------------------------------------

requireNamespace("dplyr")
requireNamespace("knitr")
requireNamespace("tidyr")
requireNamespace("stringr")
requireNamespace("ggplot2")
`%>%` <- dplyr::`%>%`

# Properties --------------------------------------------------------------

summarize_formula <- function(tbl, column) {
  tibble::tibble(
    n = tbl %>%
      dplyr::summarise(n = COUNT({{ column }})) %>%
      dplyr::pull(n),
    num_star = tbl %>%
      dplyr::filter({{ column }} %LIKE% "%*%") %>%
      dplyr::summarise(num_star = COUNT({{ column }})) %>%
      dplyr::pull(num_star),
    num_rest = tbl %>%
      dplyr::filter({{ column }} %LIKE% "%R%") %>%
      dplyr::collect() %>%
      dplyr::filter(grepl("R[^a-z]", {{ column }})) %>%
      dplyr::summarise(num_rest = dplyr::n()) %>%
      dplyr::pull(num_rest),
    num_z = tbl %>%
      dplyr::filter({{ column }} %LIKE% "%Z%") %>%
      dplyr::collect() %>%
      dplyr::filter(grepl("Z[^a-y]", {{ column }})) %>%
      dplyr::summarise(num_z = dplyr::n()) %>%
      dplyr::pull(num_z),
  )
}

summarize_inchi <- function(tbl) {
  tibble::tibble(
    n = tbl %>%
      dplyr::summarise(n = COUNT(inchi)) %>%
      dplyr::pull(n),
    num_star = tbl %>%
      dplyr::filter(inchi %LIKE% "%*%") %>%
      dplyr::collect() %>%
      dplyr::pull(inchi) %>%
      stringr::str_extract("^InChI=1[SB]/.*?/") %>%
      stringr::str_which(stringr::fixed("*")) %>%
      length(),
    num_rest = tbl %>%
      dplyr::filter(inchi %LIKE% "%R%") %>%
      dplyr::collect() %>%
      dplyr::filter(grepl("R[^a-z]", inchi)) %>%
      dplyr::summarise(num_rest = dplyr::n()) %>%
      dplyr::pull(num_rest),
    num_z = tbl %>%
      dplyr::filter(inchi %LIKE% "%Z%") %>%
      dplyr::collect() %>%
      dplyr::filter(grepl("Z[^a-y]", inchi)) %>%
      dplyr::summarise(num_z = dplyr::n()) %>%
      dplyr::pull(num_z),
  )
}

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

annotation_per_element <- function(tbl) {
  tbl %>%
    dplyr::group_by(id) %>%
    dplyr::summarize(
      num_ann = dplyr::n_distinct(identifier),
      num_prefix = dplyr::n_distinct(prefix)
    ) %>%
    dplyr::ungroup() %>%
    dplyr::collect()
}

plot_annotation <- function(tbl) {
  tbl %>%
    tidyr::pivot_longer(!id) %>%
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

name_per_element <- function(tbl) {
  tbl %>%
    dplyr::group_by(id) %>%
    dplyr::summarise(
      num_name = dplyr::n_distinct(name),
      num_prefix = dplyr::n_distinct(prefix)
    ) %>%
    dplyr::ungroup() %>%
    dplyr::collect()
}

plot_names <- function(tbl) {
  tbl %>%
    tidyr::pivot_longer(!id) %>%
    dplyr::mutate(
      name = forcats::fct_recode(name,
        "Namespaces" = "num_prefix",
        "Names" = "num_name"
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
