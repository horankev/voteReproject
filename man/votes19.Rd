% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/votes19.R
\docType{data}
\name{votes19}
\alias{votes19}
\title{Vote count for each party in 2019}
\format{
An \code{sf} dataframe with 650 rows and 19 variables:
\describe{
\item{con_code}{Factor Constituency code}
\item{constituency_name}{Factor Constituency name}
\item{region_name}{Factor Region name}
\item{majority}{int Difference in vote count between first and second-placed parties}
\item{valid_votes19}{int Number of valid votes in a constituency}
\item{con}{int Number of votes for the Conservative Party}
\item{lab}{int Number of votes for the Labour Party}
\item{ld}{int Number of votes for the Liberal Democrats}
\item{ruk}{int Number of votes for the Brexit Party (in other datasets \code{ruk} represents UKIP in 2017 election and Reform UK in 2024)}
\item{green}{int Number of votes for the Green Party}
\item{snp}{int Number of votes for the Scottish National Party}
\item{pc}{int Number of votes for Plaid Cymru}
\item{dup}{int Number of votes for the Democratic Unionist Party}
\item{sf}{int Number of votes for Sinn Fein}
\item{sdlp}{int Number of votes for the Social Democratic and Labour Party}
\item{uup}{int Number of votes for the Ulster Unionist Party}
\item{apni}{int Number of votes for the Alliance Party of Northern Ireland}
\item{other}{int Number of votes for others}
\item{geometry}{sfc_GEOMETRY Constituency boundaries 2017/2019}
}
}
\source{
\url{https://researchbriefings.files.parliament.uk/documents/CBP-8749/HoC-GE2019-results-by-constituency.csv} \url{https://ckan.publishing.service.gov.uk/dataset/westminster-parliamentary-constituencies-december-2019-boundaries-uk-bfe1/resource/a13d5188-2a5d-4867-a93d-509ea4235299}
}
\usage{
votes19
}
\description{
The number of votes obtained by each party in each constituency in the 2019 UK General Election.
}
\keyword{datasets}
