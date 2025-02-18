#' Vote count for each party in 2017 as projected to 2024 boundaries 
#'
#' The number of votes obtained by each party in each constituency in the 2017 UK General Election projected to 2024 boundaries.
#'
#' @format A dataframe with 650 rows and 31 variables:
#' \describe{
#'   \item{con_code}{Factor Constituency code}
#'   \item{apni17}{int Number of votes for the Alliance Party of Northern Ireland}
#'   \item{con17}{int Number of votes for the Conservative Party}
#'   \item{dup17}{int Number of votes for the Democratic Unionist Party}
#'   \item{green17}{int Number of votes for the Green Party} 
#'   \item{lab17}{int Number of votes for the Labour Party}
#'   \item{ld17}{int Number of votes for the Liberal Democrats}
#'   \item{other17}{int Number of votes for others}
#'   \item{pc17}{int Number of votes for Plaid Cymru}
#'   \item{ruk17}{int Number of votes for Reform UK (in other datasets `ruk` represents the Brexit Party in 2019 election and Reform UK in 2024)}
#'   \item{sdlp17}{int Number of votes for the Social Democratic and Labour Party}
#'   \item{sf17}{int Number of votes for Sinn Fein} 
#'   \item{snp17}{int Number of votes for the Scottish National Party}
#'   \item{uup17}{int Number of votes for the Ulster Unionist Party}
#'   \item{first_party17}{Factor Party with most votes in a constituency}
#'   \item{second_party17}{Factor Party with second-most votes in a constituency}
#'   \item{third_party17}{Factor Party with third-most votes in a constituency}
#'   \item{valid_votes17}{int Number of valid votes in a constituency} 
#'   \item{apni17_pct}{num Percentage of valid votes for the Alliance Party of Northern Ireland}
#'   \item{con17_pct}{num Percentage of valid votes for the Conservative Party}
#'   \item{dup17_pct}{num Percentage of valid votes for the Democratic Unionist Party}
#'   \item{green17_pct}{num Percentage of valid votes for the Green Party} 
#'   \item{lab17_pct}{num Percentage of valid votes for the Labour Party}
#'   \item{ld17_pct}{num Percentage of valid votes for the Liberal Democrats}
#'   \item{other17_pct}{num Percentage of valid votes for others}
#'   \item{pc17_pct}{num Percentage of valid votes for Plaid Cymru}
#'   \item{ruk17_pct}{num Percentage of valid votes for Reform UK (in other datasets `ruk` represents the Brexit Party in 2019 election and Reform UK in 2024)}
#'   \item{sdlp17_pct}{num Percentage of valid votes for the Social Democratic and Labour Party}
#'   \item{sf17_pct}{num Percentage of valid votes for Sinn Fein} 
#'   \item{snp17_pct}{num Percentage of valid votes for the Scottish National Party}
#'   \item{uup17_pct}{num Percentage of valid votes for the Ulster Unionist Party}
#' }
#' @source \url{https://researchbriefings.files.parliament.uk/documents/CBP-7979/HoC-GE2017-results-by-constituency.csv} \url{https://commonslibrary.parliament.uk/boundary-review-2023-which-seats-will-change/}
"votes17proj"