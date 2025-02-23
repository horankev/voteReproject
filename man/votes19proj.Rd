% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/votes19proj.R
\docType{data}
\name{votes19proj}
\alias{votes19proj}
\title{Vote count for each party in 2019 as projected to 2024 boundaries}
\format{
A dataframe with 650 rows and 31 variables:
\describe{
\item{con_code}{Factor Constituency code}
\item{apni19}{int Number of votes for the Alliance Party of Northern Ireland}
\item{con19}{int Number of votes for the Conservative Party}
\item{dup19}{int Number of votes for the Democratic Unionist Party}
\item{green19}{int Number of votes for the Green Party}
\item{lab19}{int Number of votes for the Labour Party}
\item{ld19}{int Number of votes for the Liberal Democrats}
\item{other19}{int Number of votes for others}
\item{pc19}{int Number of votes for Plaid Cymru}
\item{ruk19}{int Number of votes for Reform UK (in other datasets \code{ruk} represents the United Kingdom Independence Party in 2017 election and the Reform UK in 2024)}
\item{sdlp19}{int Number of votes for the Social Democratic and Labour Party}
\item{sf19}{int Number of votes for Sinn Fein}
\item{snp19}{int Number of votes for the Scottish National Party}
\item{uup19}{int Number of votes for the Ulster Unionist Party}
\item{first_party19}{Factor Party with most votes in a constituency}
\item{second_party19}{Factor Party with second-most votes in a constituency}
\item{third_party19}{Factor Party with third-most votes in a constituency}
\item{valid_votes19}{int Number of valid votes in a constituency}
\item{apni19_pct}{num Percentage of valid votes for the Alliance Party of Northern Ireland}
\item{con19_pct}{num Percentage of valid votes for the Conservative Party}
\item{dup19_pct}{num Percentage of valid votes for the Democratic Unionist Party}
\item{green19_pct}{num Percentage of valid votes for the Green Party}
\item{lab19_pct}{num Percentage of valid votes for the Labour Party}
\item{ld19_pct}{num Percentage of valid votes for the Liberal Democrats}
\item{other19_pct}{num Percentage of valid votes for others}
\item{pc19_pct}{num Percentage of valid votes for Plaid Cymru}
\item{ruk19_pct}{num Percentage of valid votes for Reform UK (in other datasets \code{ruk} represents the United Kingdom Independence Party in 2017 election and the Reform UK in 2024)}
\item{sdlp19_pct}{num Percentage of valid votes for the Social Democratic and Labour Party}
\item{sf19_pct}{num Percentage of valid votes for Sinn Fein}
\item{snp19_pct}{num Percentage of valid votes for the Scottish National Party}
\item{uup19_pct}{num Percentage of valid votes for the Ulster Unionist Party}
}
}
\source{
\url{https://researchbriefings.files.parliament.uk/documents/CBP-8749/HoC-GE2019-results-by-constituency.csv} \url{https://commonslibrary.parliament.uk/boundary-review-2023-which-seats-will-change/}
}
\usage{
votes19proj
}
\description{
The number of votes obtained by each party in each constituency in the 2019 UK General Election projected to 2024 boundaries.
}
\keyword{datasets}
