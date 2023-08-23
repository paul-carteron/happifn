#' @title get_ifn
#'
#' @description
#' Load IFN dataset(s) into memory. If provided, dataset are loaded from a
#' directory, else they are seamlessly downloaded before loading.
#'
#' @param dataset `character`; Name of needed dataset. If "all", every dataset
#' are returned.
#' @param dir `character` or `NULL`; connection open for writing.
#' (ex : "~/test"). If `NULL`, dataset are seamlessly imported into memory.
#' Be careful; it may take a while.
#'
#' @importFrom archive archive_read
#' @importFrom stats setNames
#' @importFrom utils read.csv2
#'
#' @return `NULL`; datasets are loaded intot emory
#' @export
#'
#' @examples
#' \dontrun{
#' TO-DO
#' }
get_ifn <- function(dataset = "arbre",
                    dir = NULL){

  bad_dataset_name <- !any(dataset %in% get_dataset_names())
  if (bad_dataset_name){
    stop("'dataset' should be one of ",
         paste0(get_dataset_names(), collapse = ", "), ".", call. = F)
  }

  global_env_var <- ls(envir = globalenv())

  if (dataset == "all"){
    dataset <- get_dataset_names()[-length(get_dataset_names())]
  }

  # remove already in memory dataset
  already_load <- dataset[dataset %in% global_env_var]
  if (length(already_load) != 0){
    warning(paste0("`", already_load, "`", collapse = ', '),
            " not loaded because they're already in the environment.",
            call. = F)
    dataset <- dataset[!dataset %in% global_env_var]

  }

  lapply(dataset,
         \(x){read.csv2(archive_read(get_url(),
                                     paste0(toupper(x),".csv")))}) |>
    setNames(tolower(dataset)) |>
    list2env(.GlobalEnv) |>
    invisible()

}
