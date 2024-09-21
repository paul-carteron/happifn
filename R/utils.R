#' @title get_url
#'
#' @usage get_url(all = FALSE)
#'
#' @param all `logical`; If `TRUE` url for downloading data since 2005 is returned.
#' Else, only data from 2022 is returned.
#' @return .zip url for downloading data
#' @export
#'
#' @examples
#' url_for_2022 <- get_url()
#' url_from_2025_to_2022 <- get_url(all = TRUE)
#'
get_url <- function(all = FALSE){
  url <- enc2utf8("https://inventaire-forestier.ign.fr/dataifn/data/export_dataifn_2022.zip")

  if (all){
    url <- enc2utf8("https://inventaire-forestier.ign.fr/dataifn/data/export_dataifn_2005_2022.zip")
  }

  return(url)

}

#' @title get_dataset_names
#'
#' @usage get_dataset_names()
#'
#' @return `character` containing all dataset name available from IFN
#' @export
#'
#' @examples
#' get_dataset_names()
#' get_dataset_names()[1]
#'
get_dataset_names <- function(){
  c("arbre", "bois_mort", "couvert", "ecologie", "flore", "habitat",
    "placette")
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
#'
#' @examples
#' \dontrun{
#' # all ifn data as lis
#' ifn_data <- get_ifn_all()
#'
#' # directly load data into globalenv
#' get_ifn_all(unlist = TRUE)
#' }
#'
get_ifn_all <- function(unlist = TRUE){

  datasets <- lapply(get_dataset_names(), get_ifn) |>
    setNames(get_dataset_names())

  if (unlist){
    list2env(datasets, envir = globalenv())
    datasets <- NULL
  }

  return(datasets)
}

#' @title ifn_as_sf
#' @description
#' helper function convert PLACETTE.csv as sf object.
#'
#' @param datasets `data.frame`; Normally only placette should be accept.
#' We'll see.
#'
#' @importFrom sf st_as_sf
#'
#' @return `sf`
#' @noRd
ifn_as_sf <- function(datasets, latlong = c("XL", "YL")){

  sf_dataset <- st_as_sf(datasets,
                         coords = latlong,
                         crs = 2154)

  return(sf_dataset)
}
