#' 2024 UK constituencies 
#'
#' Boundary data for 2024 UK General Election constituencies.
#'
#' @format An `sf` dataframe with 650 rows and 5 variables:
#' \describe{
#'   \item{con_code}{Factor Constituency code}
#'   \item{con_name}{Factor Constituency name}
#'   \item{con_abb}{Factor Three letter constituency abbreviation}
#'   \item{reg_name}{Factor Region name}
#'   \item{geometry}{sfc_GEOMETRY Constituency boundaries 2024}
#' }
#' @source \url{https://geoportal.statistics.gov.uk/maps/ons::westminster-parliamentary-constituencies-july-2024-boundaries-uk-buc-2}
"constituencies24"