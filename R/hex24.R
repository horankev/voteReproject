#' 2024 UK constituencies represented as hexagons 
#'
#' These hexagonal representations of UK constituencies overcome issues of invisibility because of very small urban area constituencies while still approximating relative position.
#'
#' @format An `sf` dataframe with 650 rows and 5 variables:
#' \describe{
#'   \item{con_code}{Factor Constituency code}
#'   \item{con_name}{Factor Constituency name}
#'   \item{con_abb}{Factor Three letter constituency abbreviation}
#'   \item{reg_name}{Factor Region name}
#'   \item{geometry}{sfc_GEOMETRY Hexagonal constituencies 2024}
#' }
#' @source \url{https://observablehq.com/@jwolondon/uk-election-2024-boundary-data}
#' Philip Brown and Alasdair Rae, Automatic Knowledge
"hex24"