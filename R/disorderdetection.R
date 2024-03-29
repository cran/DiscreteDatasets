#' @title
#' Disorder Detection data
#'
#' @docType data
#'
#' @description
#' For earlier recognition of diseases, multiple variations of the human base
#' sequence get studied. The so-called coverage of each base is calculated to
#' detect duplicates, deletions and insertions in the base sequence. To find
#' these variations a hypothesis-test gets performed for each base in the tested
#' area. The null-hypothesis being that the coverage of the base is as expected
#' under the null-hypothesis (expected coverage Cb can be calculated using a
#' given formula, following a poisson distribution). If the observed coverage is
#' exceptionally high or low the null-hypothesis gets rejected. For each type of
#' variation there is a different formula to calculate the expected coverages.
#' The expected coverages in this data set were calculated using the formula for
#' a local test without GC-correction.
#'
#' @usage data("disorderdetection")
#'
#' @format A data frame with 315 rows representing a base sequence with the
#' following 2 columns:
#' \describe{
#'   \item{\code{observed frequencies}}{Observed coverage of each base}
#'   \item{\code{expected frequencies}}{Expected coverage of each base}
#' }
#'
#' @details
#' The data was collected from the "Goodness-of-fit tests for disorder detection
#' in NGS experiments" published by the Biometrical Journal , by Jiménez-Otero,
#' de Uña-Álvarez and Pardo-Fernández. See references for more details.
#'
#' @references
#' Jiménez-Otero N, de Uña-Álvarez J, Pardo-Fernández JC (2019). Goodness-of-fit
#'    tests for disorder detection in NGS experiments.
#'    \emph{Biometrical Journal}, \strong{61}(2), pp. 424-441.
#'    \doi{10.1002/bimj.201700284}.
#'
#' @keywords datasets
"disorderdetection"
