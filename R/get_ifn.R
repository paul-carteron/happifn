#' @title get_ifn
#'
#' @description
#' Load IFN dataset(s) into memory. If provided, dataset are loaded from a
#' directory, else they are seamlessly downloaded before loading.
#'
#' @param names `character`; Name of needed dataset.
#' @param dir `character` or `NULL`; connection open for writing.
#' (ex : "~/test"). If `NULL`, dataset are seamlessly imported into memory.
#' Be careful; it may take a while.
#'
#' @importFrom stats setNames
#'
#' @return `NULL`; datasets are loaded intot emory
#' @export
#'
#' @examples
#' \dontrun{
#' all_dataset <- get_ifn(names = get_dataset_names())
#' }
get_ifn <- function(names = "arbre",
                    dir = NULL){

  # check input ----
  # bad dataset
  bad_names <- !any(names %in% c(get_dataset_names()))
  if (bad_names){
    stop("'dataset' should be one of ",
         paste0(get_dataset_names(), collapse = ", "), ".", call. = F)
  }

  # avoid redownload ----
  global_env_var <- ls(envir = globalenv())
  already_load <- names[names %in% global_env_var]

  # remove already in memory dataset
  if (length(already_load) != 0){
    warning(paste0("`", already_load, "`", collapse = ', '),
            " not loaded because already in the environment.",
            call. = F)
    names <- names[!names %in% already_load]
  }

  lapply(names, load_ifn) |>
    setNames(names) |>
    list2env(.GlobalEnv) |>
    invisible()

  return(NULL)
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
load_ifn <- function(name,
                     dir){

  name <- paste0(toupper(name),".csv")

  res <- try(read.csv2(file.path(dir, name)), silent = T)

  if(inherits(res, "try-error")){
    res <- read.csv2(archive_read(get_url(), name))
  }

  return(res)
}
