# helper function
build_table <- function(dat, new, insert_at, cn_new, cn_pre, cn_pst, cn_sep) {
  # number of old columns
  nc <- ncol(dat)

  # add new columns
  dat <- cbind(dat, new)

  # modify headers
  colnames(dat)[-(1:nc)] <- cn_new
  if(!is.null(cn_pre))
    colnames(dat) <- paste(cn_pre, colnames(dat), sep = cn_sep)
  if(!is.null(cn_pst))
    colnames(dat) <- paste(colnames(dat), cn_pst, sep = cn_sep)

  # reorder according to 'insert_at'
  dat <- dat[order(c(setdiff(1:4, insert_at), insert_at))]

  return(dat)
}


#' @title
#' Reconstruct a set of four-fold tables from rows or columns
#'
#' @description
#' In some situations, fourfold tables are reduced to two elements, which makes
#' it impossible to use them straight away for statistical tests like Fisher's
#' exact test. But sometimes, when all tables had the same known marginal sums,
#' the missing values can be restored using that additional information. The
#' \code{reconstruct_two} function uses a set of such reduced tables, stored
#' row-wise in a matrix or a data frame, and rebuilds the two missing columns
#' from automatically computed or given marginal totals.
#'
#' @param dat                 integer matrix or data frame with exactly two
#'                            columns; each row represents the first column of a
#'                            2x2 matrix for which the other two values are to
#'                            be computed and appended to \code{dat} as two new
#'                            columns; real numbers will be coerced to integer.
#' @param totals              integer vector of exactly one or two values or
#'                            \code{NULL} (the default); the new columns will be
#'                            derived by subtracting the existing column values
#'                            from \code{totals}; if \code{NULL}, the sums of
#'                            the two existing columns of \code{dat} are used.
#' @param insert_at           integer vector of exactly two values between 1 and
#'                            4 or \code{NULL} (the default) indicating the
#'                            indices at which the values are to be inserted; if
#'                            \code{NULL}, the new values are appended at the
#'                            end, i.e. at positions 3 and 4.
#' @param colnames_add        character vector of exactly two unique character
#'                            strings or \code{NULL} (the default), which
#'                            contains the desired headers of the new
#'                            (reconstructed) columns of the input; if
#'                            \code{NULL}, the headers of \code{dat} are used
#'                            (with appended strings; see below).
#' @param colnames_prepend    character vector of exactly two unique character
#'                            strings (\code{NA}s are allowed) or \code{NULL}
#'                            (the default); the first string will be prepended
#'                            to the headers of the original headers of
#'                            \code{dat}, while the second is used in
#'                            the same manner for the reconstructed columns.
#' @param colnames_append     character vector of exactly two unique character
#'                            strings (\code{NA}s are allowed) or \code{NULL}
#'                            (the default); the first string will be appended
#'                            to the headers of the original headers of
#'                            \code{dat}, while the second is used in
#'                            the same manner for the reconstructed columns; if
#'                            \code{colnames_add = NULL} and
#'                            \code{colnames_append = NULL}, \code{c("A", "B")}
#'                            will be used.
#' @param colnames_sep        a single character or \code{NULL} (the default)
#'                            giving the separator for combining
#'                            \code{colnames_prepend} and \code{colnames_append}
#'                            with the column names.
#'
#' @return
#' An integer data frame with four columns.
#'
#' @examples
#' data(amnesia)
#' amnesia_four_columns <- reconstruct_two(
#'   amnesia,
#'   NULL,
#'   NULL,
#'   NULL,
#'   NULL,
#'   c("ThisDrug", "AllOtherDrugs"),
#'   "."
#' )
#' head(amnesia_four_columns)
#'
#' data(hiv)
#' hiv_four_columns <- reconstruct_two(
#'   hiv,
#'   73,
#'   NULL,
#'   NULL,
#'   NULL,
#'   c("Mutation", "NoMutation"),
#'   "."
#' )
#' head(hiv_four_columns)
#'
#' data(listerdata)
#' listerdata_four_columns <- reconstruct_two(
#'   listerdata,
#'   c(34244, 39342),
#'   NULL,
#'   NULL,
#'   NULL,
#'   c("This_Cyto", "All_Other_Cytos"),
#'   "_"
#' )
#' head(listerdata_four_columns)
#'
#' @export
#' @importFrom checkmate assert_data_frame assert_character assert_numeric
reconstruct_two <- function(dat, totals = NULL, insert_at = NULL, colnames_add = NULL, colnames_prepend = NULL, colnames_append = NULL, colnames_sep = "_") {
  # check inputs
  if(is.matrix(dat))
    dat <- as.data.frame(dat)

  assert_data_frame(dat, "numeric", FALSE, ncols = 2)

  assert_character(colnames_add,     any.missing = FALSE, len = 2, unique = TRUE, null.ok = TRUE)
  assert_character(colnames_prepend, len = 2, unique = TRUE, null.ok = TRUE)
  assert_character(colnames_append,  len = 2, unique = TRUE, null.ok = TRUE)
  assert_character(colnames_sep, min.chars = 0, max.chars = 1, any.missing = FALSE, len = 1, null.ok = TRUE)

  assert_numeric(totals, lower = 1, min.len = 1, max.len = 2, any.missing = FALSE, null.ok = TRUE)

  assert_numeric(insert_at, 1, 4, any.missing = FALSE, len = 2, unique = TRUE, null.ok = TRUE)

  # coerce numeric inputs to integer
  dat[] <- sapply(dat, as.integer)

  # reconstruct values
  if(is.null(totals))
    totals <- colSums(dat)
  totals <- as.integer(totals)
  new_cols <- matrix(totals, nrow(dat), 2, byrow = TRUE) - dat

  # where to insert the reconstructed values (columns)
  if(is.null(insert_at))
    insert_at <- 3:4 else
      insert_at[] <- as.integer(insert_at)

  # prepare headers, prefix and postfix strings
  if(!is.null(colnames_prepend)) {
    colnames_prepend[is.na(colnames_prepend)] <- ""
    colnames_prepend <- rep(rep_len(colnames_prepend, 2), c(2, 2))
  }

  if(is.null(colnames_add) && is.null(colnames_append)) {
    colnames_append <- rep(c("A", "B"), c(2, 2))
  } else if(!is.null(colnames_append)) {
    colnames_append[is.na(colnames_append)] <- ""
    colnames_append <- rep(rep_len(colnames_append, 2), c(2, 2))
  }

  if(is.null(colnames_add))
    colnames_add <- colnames(dat)

  # build reconstructed table
  dat <- build_table(dat, new_cols, insert_at, colnames_add, colnames_prepend, colnames_append, colnames_sep)

  return(dat)
}



#' @title
#' Reconstruct a set of reformatted four-fold tables
#'
#' @description
#' Sometimes, fourfold tables are reformatted by replacing rows or columns by
#' marginal totals. This makes it impossible to use them straight away for
#' statistical tests like Fisher's exact test. But with that knowledge, the
#' missing values can easily be restored. The \code{reconstruct_four}
#' function uses a set of such reduced tables, stored row-wise in a matrix or a
#' data frame, and rebuilds the two reformatted cells when they were replaced by
#' marginal totals.
#'
#' @param dat                 integer matrix or data frame with exactly two
#'                            columns; each row represents the first column of a
#'                            2x2 matrix for which the other two values are to
#'                            be computed and appended to \code{dat} as two new
#'                            columns; real numbers will be coerced to integer.
#' @param idx_marginals       integer vector of exactly two values or
#'                            \code{NULL} (the default) indicating the columns
#'                            of \code{dat} that contain the marginal totals;
#'                            if \code{NULL}, the last two columns are used.
#' @param colnames_add        character vector of exactly two unique character
#'                            strings or \code{NULL} (the default), which
#'                            contains the desired headers of the new
#'                            (reconstructed) columns of the input; if
#'                            \code{NULL}, the headers of the marginal totals
#'                            are used.
#'
#' @return
#' An integer data frame with four columns.
#'
#' @examples
#' X1 <- c(4, 2, 2, 14, 6, 9, 4, 0, 1)
#' X2 <- c(0, 0, 1, 3, 2, 1, 2, 2, 2)
#' N1 <- rep(148, 9)
#' N2 <- rep(132, 9)
#'
#' df1 <- data.frame(X1, X2, N1, N2)
#' reconstruct_four(df1, colnames_add = c("Y1", "Y2"))
#' # same as reconstruct_four(df1, c(3, 4), c("Y1", "Y2"))
#'
#' df2 <- data.frame(X1, N1, X2, N2)
#' reconstruct_four(df2, c(2, 4), c("Y1", "Y2"))
#'
#' @export
#' @importFrom checkmate assert_data_frame assert_character assert_numeric
reconstruct_four <- function(dat, idx_marginals = NULL, colnames_add = NULL) {
  # check inputs
  if(is.matrix(dat))
    dat <- as.data.frame(dat)

  assert_data_frame(dat, "numeric", FALSE, ncols = 4)
  assert_numeric(idx_marginals, 1, 4, any.missing = FALSE, len = 2, unique = TRUE, null.ok = TRUE)
  assert_character(colnames_add, len = 2, unique = TRUE, null.ok = TRUE)

  # coerce numeric inputs to integer
  dat[] <- sapply(dat, as.integer)

  # compute new columns
  if(is.null(idx_marginals))
    idx_marginals <- 3:4 else
      idx_marginals[] <- as.integer(idx_marginals)

  new_cols <- dat[idx_marginals] - dat[-idx_marginals]

  # prepare headers
  if(is.null(colnames_add))
    colnames_add <- colnames(dat[idx_marginals])

  # build reconstructed table
  dat <- build_table(dat[-idx_marginals], new_cols, idx_marginals, colnames_add, NULL, NULL, NULL)

  return(dat)
}
