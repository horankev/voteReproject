#' Palette of party colours 
#'
#' Colour associated with each party.
#'
#' @format A named vector of length 14:
#' \describe{
#'   \item{con_code}{Factor Constituency code}
#'   \item{constituency_name}{Factor Constituency name} 
#'   \item{region_name}{Factor Region name}
#'   \item{majority}{int Difference in vote count between first and second-placed parties}
#'   \item{valid_votes17}{int Number of valid votes in a constituency}
#'   \item{con}{int Number of votes for the Conservative Party} 
#'   \item{lab}{int Number of votes for the Labour Party}
#'   \item{ld}{int Number of votes for the Liberal Democrats}
#'   \item{ruk}{int Number of votes for the United Kingdom Independence Party (in other datasets `ruk` represents the Brexit Party in 2019 election and Reform UK in 2024)}
#'   \item{green}{int Number of votes for the Green Party} 
#'   \item{snp}{int Number of votes for the Scottish National Party}
#'   \item{pc}{int Number of votes for Plaid Cymru}
#'   \item{dup}{int Number of votes for the Democratic Unionist Party}
#'   \item{sf}{int Number of votes for Sinn Fein} 
#'   \item{sdlp}{int Number of votes for the Social Democratic and Labour Party}
#'   \item{uup}{int Number of votes for the Ulster Unionist Party}
#'   \item{apni}{int Number of votes for the Alliance Party of Northern Ireland} 
#'   \item{other}{int Number of votes for others}
#'   \item{geometry}{sfc_GEOMETRY Constituency boundaries 2017/2019}
#' }
#' @source \url{https://en.wikipedia.org/wiki/Wikipedia:WikiProject_Politics_of_the_United_Kingdom/Index_of_United_Kingdom_political_parties_meta_attributes}
"party_palette"

