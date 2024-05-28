#' @title
#' Airway smooth muscle cells
#'
#' @docType data
#'
#' @description
#' Read counts per gene for airway smooth muscle cell lines RNA-Seq experiment
#'
#' @usage
#' data("airway")
#'
#' @format
#' \code{airway} is a \code{data.frame} with 63,677 rows and 8 columns. Each row
#' corresponds to a specific gene and each column to a labeled sample.
#'
#' @details
#' The cell lines of the even-numbered samples were treated with dexamethasone,
#' whereas the cell lines of the odd-numbered samples were not. There were
#' 89,561,179 reads for all treated samples and 85,955,244 for the untreated
#' ones.
#'
#' @source
#' FASTQ files from SRA, phenotypic data from GEO
#'
#' @note
#' The original \code{airway} dataset has been taken from the
#' \code{\link[airway:airway]{airway}} BioConductor package. Since the original
#' data would require other BioConductor packages to access it, it has been
#' reformatted to a standard data frame (with \code{assay(airway)}) which only
#' contains the raw numeric data.
#'
#' @references
#' Himes, B. E., Jiang, X., Wagner, P., Hu, R., Wang, Q., Klanderman, B.,
#'    Whitaker, R. M., Duan, Q., Lasky-Su, J., Nikolos, C., Jester, W.,
#'    Johnson, M., Panettieri, R. Jr., Tantisira, K. G., Weiss, S. T., Lu, Q.
#'    (2014). RNA-Seq Transcriptome Profiling Identifies CRISPLD2 as a
#'    Glucocorticoid Responsive Gene that Modulates Cytokine Function in Airway
#'    Smooth Muscle Cells. \emph{PLoS One} \strong{9}(6).
#'    \doi{https://doi.org/10.1371/journal.pone.0099625}
#'
#' @keywords datasets
"airway"

#' @rdname airway
#'
#' @usage data("airway_treat")
#'
#' @format
#' \code{airway_treat} is a \code{data.frame} with 63,677 rows representing
#' genes with the following two columns:
#' \describe{
#'   \item{Treatment}{Number of reads for the specific gene in all treated
#'                    samples.}
#'   \item{NoTreatment}{Number of reads for the specific gene in all untreated
#'                      samples.}
#' }
#' Thus, each line describes a 2x2 table, e.g.:
#' \tabular{rcc}{
#'   ENSG00000000003 \tab This gene      \tab All other genes\cr
#'   Treatment       \tab \eqn{X_{i, 1}} \tab 89,561,179 - \eqn{X_{i, 1}}\cr
#'   No Treatment    \tab \eqn{X_{i, 2}} \tab 85,955,244 - \eqn{X_{i, 2}}
#' }
"airway_treat"

#' @rdname airway
#'
#' @usage data("airway_four_columns")
#'
#' @format
#' \code{airway_four_columns} is a \code{data.frame} with 63,677 rows
#' representing genes with the following four columns:
#' \describe{
#'   \item{Treatment.ThisGene}{Number of reads for the specific gene in all
#'                             treated samples.}
#'   \item{NoTreatment.ThisGene}{Number of reads for the specific gene in all
#'                               untreated samples.}
#'   \item{Treatment.AllOtherGenes}{Number of reads for all other genes in all
#'                                  treated samples.}
#'   \item{NoTreatment.AllOtherGenes}{Number of reads for tall other genes in
#'                                    all untreated samples.}
#' }
#' Thus, each line describes a 2x2 table, e.g.:
#' \tabular{rcc}{
#'   ENSG00000000003 \tab This gene      \tab All other genes\cr
#'   Treatment       \tab \eqn{X_{i, 1}} \tab \eqn{X_{i, 3}}\cr
#'   No Treatment    \tab \eqn{X_{i, 2}} \tab \eqn{X_{i, 4}}
#' }
"airway_four_columns"
