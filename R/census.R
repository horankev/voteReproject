#' Census data 
#'
#' Selection of data from 2021 census of England and Wales.
#'
#' @format A dataframe with 575 rows and 6 variables:
#' \describe{
#'   \item{con_code}{Factor Constituency code}
#'   \item{over65}{num Proportion of population in constituency aged over 65}
#'   \item{degree}{num Proportion of population in constituency with a degree} 
#'   \item{notgoodhealth}{num Proportion of population in constituency reporting fair, bad or very bad health}
#'   \item{white}{num Proportion of population in constituency of white ethnicity}
#'   \item{pop-tot}{num Population of constituency}
#' }
#' @source \url{https://statistics.ukdataservice.ac.uk/dataset/?q=census+2021&sort=score+desc%2C+metadata_modified+desc&vocab_Area_type=Westminster+Parliamentary+Constituencies}
"census"