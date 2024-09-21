#' @title get_ifn_metadata
#'
#' @description
#' Load a list with three metadata dataset
#'
#' @usage get_ifn_metadata(dir = NULL,
#'                     unlist = FALSE,
#'                     quiet = FALSE)
#'
#' @inheritParams get_ifn
#' @param unlist `boolean`; if TRUE, all datasets are load into globalenv. if
#' FALSE, a list of datasets is returned.
#'
#' @return `list`; three dataset
#' @export
#'
#' @examples
#' \dontrun{
#' TO-DO
#' }
get_ifn_metadata <- function(dir = NULL,
                             unlist = FALSE,
                             quiet = FALSE){

  metadata <- list(code = load_code(dir, quiet),
                   units = load_units(dir, quiet),
                   units_value_set = load_units_value_set(dir, quiet))

  if (unlist){
    list2env(metadata, envir = globalenv())
    metadata <- NULL
  }

  return(metadata)
}

#' @importFrom archive archive_read
#' @importFrom utils read.csv2
#' @noRd
#'
load_code <- function(dir = NULL,
                      quiet = FALSE){

  if (!quiet){message("Loading CODE dataset...")}

  if (is.null(dir)){
    dir <- archive_read(get_url(), "metadonnees.csv")
  }else{
    dir <- file.path(dir,  "metadonnees.csv")
  }

  codes <- read.csv2(dir, skip = 17, nrows = 163,
                     row.names = NULL)

  codes[,3] <- paste0(codes[,3], codes[,4])
  codes <- codes[ , -ncol(codes)]
  names(codes) <- c("code", "libelle", "definition")

  return(codes)
}

#' @importFrom archive archive_read
#' @importFrom utils read.csv2
#' @noRd
#'
load_units <- function(dir = NULL,
                       quiet = FALSE){

  if (!quiet){message("Loading UNITS dataset...")}

  if (is.null(dir)){
    dir <- archive_read(get_url(all = FALSE), "metadonnees.csv")
  }else{
    dir <- file.path(dir,  "metadonnees.csv")
  }

  units <- read.csv2(dir, skip = 184, nrows = 231,
                     row.names = NULL)
  units <- units[,-ncol(units)]
  names(units) <- c("data", "units", "campagnes", "type", "libelle", "definition")

  return(units)
}

#' @importFrom archive archive_read
#' @importFrom utils read.csv2
#' @noRd
#'
load_units_value_set <- function(dir = NULL,
                                 quiet = FALSE){

  if (!quiet){message("Loading UNITS_VALUE_SET dataset...")}

  if (is.null(dir)){
    dir <- archive_read(get_url(), "metadonnees.csv")
  }else{
    dir <- file.path(dir,  "metadonnees.csv")
  }

  units_value_set <- read.csv2(dir, skip = 380,
                               row.names = NULL)
  units_value_set <- units_value_set[ , -ncol(units_value_set)]
  names(units_value_set) <- c("units", "code", "libelle", "definition")

  return(units_value_set)
}
