#' @title
#' The Federalist Papers word count data
#'
#' @docType data
#'
#' @description
#'
#' Author assignments and counts of the 1,500 most common
#' words from "The Federalist" articles.
#'
#' "The Federalist Papers" are a set of 85 articles written under the pseudonym
#' "Publius" to promote the ratification of the US constitution by Alexander
#' Hamilton, James Madison and John Jay in 1787 and 1788. There are multiple
#' sources which attribute the articles to their real
#' authors. We use the attributions by the Project Gutenberg
#' and the correction by the authors of the \code{syllogi} package.
#' This task has been a popular problem in natural language
#' processing. One of the most prominent examples is the work by Mosteller
#' and Wallace (1964) who used the word frequencies to attribute the
#' disputed articles to their authors.
#'
#' The data provided in this package was prepared with the following steps
#' by employing the \code{tm} package:
#'  \enumerate{
#'    \item{Load the texts from the \code{syllogi} package,}
#'    \item{Lowercase,}
#'    \item{Remove punctuation,}
#'    \item{Strip whitespace,}
#'    \item{Remove the texts by Jay, one text coauthored by
#'         Madison and Hamilton together, and the redundant
#'         version of article 70,}
#'    \item{Find the 1,500 most common words for each author,}
#'    \item{Count the occurrences of these words in the texts.}
#' }
#'
#' @usage data("federalist")
#'
#' @format
#' \code{federalist} is a \code{data.frame} with 77 rows and 1,984
#' columns:
#' \describe{
#'   \item{doc_no}{Article number}
#'   \item{doc_author}{Author of the article (according to Project
#'         Gutenberg)}
#'   \item{...}{The remaining 1,982 columns are the word counts}
#' }
#'
#' @references
#' Watson, G. S. (1966). Review: Frederick Mosteller, David L. Wallace, 
#'    Inference and Disputed Authorship: The Federalist.
#'    \emph{The Annals of Mathematical Statistics}, \strong{37}(1), 308-312.
#'    \doi{10.1214/aoms/1177699628}
#'
#' Donoho, D. L., & Kipnis, A. (2022). Higher criticism to compare two large
#'    frequency tables, with sensitivity to possible rare and weak differences.
#'    \emph{Annals of Statistics}, \strong{50}(3), 1447-1472.
#'    \doi{10.1214/21-AOS2158}
#'
#' Feinerer, I., & Hornik, K. (2024). tm: Text Mining Package. R package
#'    version 0.7-15. \emph{CRAN}. \url{https://CRAN.R-project.org/package=tm}
#'
#' Studyvin, J. (2024). syllogi: Collection of Data Sets for Teaching Purposes.
#'    R package version 1.0.3. \emph{CRAN}.
#'    \url{https://CRAN.R-project.org/package=syllogi}
#' @keywords datasets
"federalist"