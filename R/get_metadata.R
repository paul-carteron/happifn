#' @title get_metadata
#'
#' @description
#' Load a list with three metadata dataset
#'
#' @param dir `character` or `NULL`; connection open for writing.
#' (ex : "~/test"). If `NULL`, dataset are seamlessly imported into memory.
#' Be careful; it may take a while.
#'
#' @return `list`; three dataset
#' @export
#'
#' @examples
#' \dontrun{
#' TO-DO
#' }
get_metadata <- function(dir = NULL){

  res <- list(code = load_code(dir),
              units = load_units(dir),
              units_value_set = load_units_value_set(dir))

  return(res)
}

#' @importFrom archive archive_read
#' @importFrom utils read.csv2
load_code <- function(dir = NULL){

  dir <- file.path(dir, "metadonnees.csv")
  if (is.null(dir)){
    dir <- archive_read(get_url(), "metadonnees.csv")
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
load_units <- function(dir = NULL){

  dir <- file.path(dir, "metadonnees.csv")
  if (is.null(dir)){
    dir <- archive_read(get_url(), "metadonnees.csv")
  }

  units <- read.csv2(dir, skip = 184, nrows = 152,
                     row.names = NULL)
  units <- units[,-ncol(units)]
  names(units) <- c("data", "units", "campagnes", "type", "libelle", "definition")

  return(units)
}

#' @importFrom archive archive_read
#' @importFrom utils read.csv2
load_units_value_set <- function(dir = NULL){

  dir <- file.path(dir, "metadonnees.csv")
  if (is.null(dir)){
    dir <- archive_read(get_url(), "metadonnees.csv")
  }

  units_value_set <- read.csv2(dir, skip = 337,
                               row.names = NULL)
  units_value_set <- units_value_set[ , -ncol(units_value_set)]
  names(units_value_set) <- c("units", "code", "libelle", "definition")

  return(units_value_set)
}
