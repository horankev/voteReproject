#' Vote count for each party in 2017, 2019 and 2024, all as projected to 2024 boundaries 
#'
#' The number of votes obtained by each party in each constituency in the 2017, 2019 and 2024 UK General Elections, all projected to 2024 boundaries.
#'
#' @format An `sf` dataframe with 650 rows and 99 variables:
#' \describe{
#'   \item{con_code}{Factor Constituency code}
#'   \item{constituency_name}{Factor Constituency name} 
#'   \item{region_name}{Factor Region name}
#'   \item{first_party24}{Factor Party with most votes in a constituency}
#'   \item{second_party24}{Factor Party with second-most votes in a constituency}
#'   \item{third_party24}{Factor Party with third-most votes in a constituency} 
#'   \item{con24}{int Number of votes for the Conservative Party}
#'   \item{lab24}{int Number of votes for the Labour Party}
#'   \item{ld24}{int Number of votes for the Liberal Democrats}
#'   \item{ruk24}{int Number of votes for Reform UK (in other datasets `ruk` represents the United Kingdom Independence Party in 2017 election and the Brexit Party in 2019)}
#'   \item{green24}{int Number of votes for the Green Party} 
#'   \item{snp24}{int Number of votes for the Scottish National Party}
#'   \item{pc24}{int Number of votes for Plaid Cymru}
#'   \item{dup24}{int Number of votes for the Democratic Unionist Party}
#'   \item{sf24}{int Number of votes for Sinn Fein} 
#'   \item{sdlp24}{int Number of votes for the Social Democratic and Labour Party}
#'   \item{uup24}{int Number of votes for the Ulster Unionist Party}
#'   \item{apni24}{int Number of votes for the Alliance Party of Northern Ireland} 
#'   \item{other24}{int Number of votes for others}
#'   \item{valid_votes24}{int Number of valid votes in a constituency} 
#'   \item{majority}{int Difference in vote count between first and second-placed parties}
#'   \item{con24_pct}{num Percentage of valid votes for the Conservative Party}
#'   \item{lab24_pct}{num Percentage of valid votes for the Labour Party}
#'   \item{ld24_pct}{num Percentage of valid votes for the Liberal Democrats}
#'   \item{ruk24_pct}{num Percentage of valid votes for Reform UK (in other datasets `ruk` represents the United Kingdom Independence Party in 2017 election and the Brexit Party in 2019)}
#'   \item{green24_pct}{num Percentage of valid votes for the Green Party} 
#'   \item{snp24_pct}{num Percentage of valid votes for the Scottish National Party}
#'   \item{pc24_pct}{num Percentage of valid votes for Plaid Cymru}
#'   \item{dup24_pct}{num Percentage of valid votes for the Democratic Unionist Party}
#'   \item{sf24_pct}{num Percentage of valid votes for Sinn Fein} 
#'   \item{sdlp24_pct}{num Percentage of valid votes for the Social Democratic and Labour Party}
#'   \item{uup24_pct}{num Percentage of valid votes for the Ulster Unionist Party}
#'   \item{apni24_pct}{num Percentage of valid votes for the Alliance Party of Northern Ireland}
#'   \item{other24_pct}{num Percentage of valid votes for others}
#'   \item{apni19}{int Number of votes for the Alliance Party of Northern Ireland}
#'   \item{con19}{int Number of votes for the Conservative Party}
#'   \item{dup19}{int Number of votes for the Democratic Unionist Party}
#'   \item{green19}{int Number of votes for the Green Party} 
#'   \item{lab19}{int Number of votes for the Labour Party}
#'   \item{ld19}{int Number of votes for the Liberal Democrats}
#'   \item{other19}{int Number of votes for others}
#'   \item{pc19}{int Number of votes for Plaid Cymru}
#'   \item{ruk19}{int Number of votes for Reform UK (in other datasets `ruk` represents the United Kingdom Independence Party in 2017 election and the Reform UK in 2024)}
#'   \item{sdlp19}{int Number of votes for the Social Democratic and Labour Party}
#'   \item{sf19}{int Number of votes for Sinn Fein} 
#'   \item{snp19}{int Number of votes for the Scottish National Party}
#'   \item{uup19}{int Number of votes for the Ulster Unionist Party}
#'   \item{first_party19}{Factor Party with most votes in a constituency}
#'   \item{second_party19}{Factor Party with second-most votes in a constituency}
#'   \item{third_party19}{Factor Party with third-most votes in a constituency}
#'   \item{valid_votes19}{int Number of valid votes in a constituency} 
#'   \item{apni19_pct}{num Percentage of valid votes for the Alliance Party of Northern Ireland}
#'   \item{con19_pct}{num Percentage of valid votes for the Conservative Party}
#'   \item{dup19_pct}{num Percentage of valid votes for the Democratic Unionist Party}
#'   \item{green19_pct}{num Percentage of valid votes for the Green Party} 
#'   \item{lab19_pct}{num Percentage of valid votes for the Labour Party}
#'   \item{ld19_pct}{num Percentage of valid votes for the Liberal Democrats}
#'   \item{other19_pct}{num Percentage of valid votes for others}
#'   \item{pc19_pct}{num Percentage of valid votes for Plaid Cymru}
#'   \item{ruk19_pct}{num Percentage of valid votes for Reform UK (in other datasets `ruk` represents the United Kingdom Independence Party in 2017 election and the Reform UK in 2024)}
#'   \item{sdlp19_pct}{num Percentage of valid votes for the Social Democratic and Labour Party}
#'   \item{sf19_pct}{num Percentage of valid votes for Sinn Fein} 
#'   \item{snp19_pct}{num Percentage of valid votes for the Scottish National Party}
#'   \item{uup19_pct}{num Percentage of valid votes for the Ulster Unionist Party}
#'   \item{con17}{int Number of votes for the Conservative Party}
#'   \item{dup17}{int Number of votes for the Democratic Unionist Party}
#'   \item{green17}{int} 
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
#'   \item{over65}{num Proportion of population in constituency aged over 65}
#'   \item{degree}{num Proportion of population in constituency with a degree} 
#'   \item{notgoodhealth}{num Proportion of population in constituency reporting fair, bad or very bad health}
#'   \item{white}{num Proportion of population in constituency of white ethnicity}
#'   \item{geometry}{sfc_GEOMETRY Constituency boundaries 2024}
#' }
#' @source \url{https://researchbriefings.files.parliament.uk/documents/CBP-7979/HoC-GE2017-results-by-constituency.csv} \url{https://researchbriefings.files.parliament.uk/documents/CBP-8749/HoC-GE2019-results-by-constituency.csv} \url{https://researchbriefings.files.parliament.uk/documents/CBP-10009/HoC-GE2024-results-by-constituency.csv} \url{https://geoportal.statistics.gov.uk/maps/ons::westminster-parliamentary-constituencies-july-2024-boundaries-uk-buc-2} \url{https://commonslibrary.parliament.uk/boundary-review-2023-which-seats-will-change/}
"votestogether"