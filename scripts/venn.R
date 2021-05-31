# Dependencies ------------------------------------------------------------

requireNamespace("dplyr")
requireNamespace("VennDiagram")
requireNamespace("rcartocolor")
`%>%` <- dplyr::`%>%`

# Plots -------------------------------------------------------------------

plot_venn_mass <- function(tbl, id_column) {
  formula <- tbl %>%
    dplyr::filter(!is.na(formula)) %>%
    dplyr::pull({{ id_column }})
  smiles <- tbl %>%
    dplyr::filter(!is.na(smiles)) %>%
    dplyr::pull({{ id_column }})
  inchi <- tbl %>%
    dplyr::filter(!is.na(inchi)) %>%
    dplyr::pull({{ id_column }})
  mass <- tbl %>%
    dplyr::filter(!is.na(mass)) %>%
    dplyr::pull({{ id_column }})

  VennDiagram::draw.quad.venn(
    area1 = length(formula),
    area2 = length(smiles),
    area3 = length(inchi),
    area4 = length(mass),
    n12 = intersect(formula, smiles) %>% length(),
    n13 = intersect(formula, inchi) %>% length(),
    n14 = intersect(formula, mass) %>% length(),
    n23 = intersect(smiles, inchi) %>% length(),
    n24 = intersect(smiles, mass) %>% length(),
    n34 = intersect(inchi, mass) %>% length(),
    n123 = intersect(formula, smiles) %>% intersect(inchi) %>% length(),
    n124 = intersect(formula, smiles) %>% intersect(mass) %>% length(),
    n134 = intersect(formula, inchi) %>% intersect(mass) %>% length(),
    n234 = intersect(smiles, inchi) %>% intersect(mass) %>% length(),
    n1234 = intersect(formula, smiles) %>% intersect(inchi) %>% intersect(mass) %>% length(),
    print.mode = c("raw", "percent"),
    category = c("Formula", "SMILES", "InChI", "Mass"),
    fill = rcartocolor::carto_pal(4, "Safe"),
    lty = "blank"
  )
}

plot_venn_charge <- function(tbl, id_column) {
  formula <- tbl %>%
    dplyr::filter(!is.na(formula)) %>%
    dplyr::pull({{ id_column }})
  smiles <- tbl %>%
    dplyr::filter(!is.na(smiles)) %>%
    dplyr::pull({{ id_column }})
  inchi <- tbl %>%
    dplyr::filter(!is.na(inchi)) %>%
    dplyr::pull({{ id_column }})
  charge <- tbl %>%
    dplyr::filter(!is.na(charge)) %>%
    dplyr::pull({{ id_column }})

  VennDiagram::draw.quad.venn(
    area1 = length(formula),
    area2 = length(smiles),
    area3 = length(inchi),
    area4 = length(charge),
    n12 = intersect(formula, smiles) %>% length(),
    n13 = intersect(formula, inchi) %>% length(),
    n14 = intersect(formula, charge) %>% length(),
    n23 = intersect(smiles, inchi) %>% length(),
    n24 = intersect(smiles, charge) %>% length(),
    n34 = intersect(inchi, charge) %>% length(),
    n123 = intersect(formula, smiles) %>% intersect(inchi) %>% length(),
    n124 = intersect(formula, smiles) %>% intersect(charge) %>% length(),
    n134 = intersect(formula, inchi) %>% intersect(charge) %>% length(),
    n234 = intersect(smiles, inchi) %>% intersect(charge) %>% length(),
    n1234 = intersect(formula, smiles) %>% intersect(inchi) %>% intersect(charge) %>% length(),
    print.mode = c("raw", "percent"),
    category = c("Formula", "SMILES", "InChI", "Charge"),
    fill = rcartocolor::carto_pal(4, "Safe"),
    lty = "blank"
  )
}
