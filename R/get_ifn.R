#' @title get_ifn
#'
#' @description
#' Load IFN dataset(s) into memory. If provided, dataset are loaded from a
#' directory, else they are seamlessly downloaded before loading.
#'
#' @usage get_ifn(name,
#'                dir = NULL,
#'                quiet = FALSE)
#'
#' @param name `character`; Name of needed dataset.
#' @param dir `character` or `NULL`; connection open for writing.
#' (ex : "~/test"). If `NULL`, dataset are seamlessly imported into memory.
#' Be careful; it may take a while.
#' @param quiet `boolean`; If TRUE no message are displayed.
#'
#' @importFrom stats setNames
#'
#' @return `NULL`; datasets are loaded intot emory
#' @export
#'
#' @examples
#' \dontrun{
#' arbre <- get_ifn(name = "arbre", dir = NULL)
#'
#' }
get_ifn <- function(name,
                    dir = NULL,
                    quiet = FALSE){

  # check input ----
  # dataset
  if (length(name) != 1){
    stop("`name` should be of length 1, not ", length(name), ".", call. = FALSE)
  }

  bad_name <- !(name %in% get_dataset_names())
  if (bad_name){
    stop("`name` should be one of ",
         paste0(get_dataset_names(), collapse = ", "), ".", call. = FALSE)
  }

  # dir
  if (!inherits(dir, c("character", "NULL"))){
    stop("`dir` should be of class `character` or `NULL`", call. = FALSE)
  }

  bad_dir <- !is.null(dir) && !dir.exists(dir)
  if (bad_dir){
    stop("`dir` does not exist. Check with `dir.exists(dir)`", call. = FALSE)
  }

  # load dataset ----
  dataset <- load_ifn(name, dir, quiet)

  if (name == "placette"){
    dataset <- ifn_as_sf(dataset)
  }

  return(dataset)
}

#' @title get_ifn_all
#' @description
#' Wrapper function to load all ifn datasets
#'
#' @usage get_ifn_all(unlist = TRUE)
#'
#' @param unlist `boolean`; if TRUE, all datasets are load into globalenv. if
#' FALSE, a list of datasets is returned.
#'
#' @return `NULL` or `list`
#' @export
get_ifn_all <- function(unlist = TRUE){

  datasets <- lapply(get_dataset_names(), get_ifn) |>
    setNames(get_dataset_names())

  if (unlist){
    list2env(datasets, envir = globalenv())
    datasets <- NULL
  }

  return(datasets)
}

#' load_ifn
#'
#' @param name `character`; Name of needed dataset.
#' @inheritParams get_ifn
#'
#' @importFrom archive archive_read
#' @importFrom utils read.csv2
#'
#' @return `data.frame`; dataset
#' @noRd
#'
load_ifn <- function(name, dir, quiet){

  name <- paste0(toupper(name),".csv")

  res <- try(read.csv2(file.path(dir, name),
                       fileEncoding = "UTF-8",
                       na.strings = c("NA", "", " ")), silent = TRUE)

  if(inherits(res, "try-error")){
    if (!quiet){message("Loading ", name, " dataset...")}

    res <- read.csv2(archive_read(get_url(all = TRUE), name),
                     fileEncoding = "UTF-8",
                     na.strings = c("NA", "", " "))
    # all dataset have an empty X column at the end
    res <- res[ , -ncol(res)]
  }

  return(res)
}
