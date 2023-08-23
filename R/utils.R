#' @title get_url
#'
#' @usage get_url(all = F)
#'
#' @param all `logical`; If `TRUE` url for downloading data since 2005 is returned.
#' Else, only data from 2021 is returned.
#' @return .zip url for downloading data
#' @export
#'
#' @examples
#' \dontrun{
#' get_url()
#' }
get_url <- function(all = F){
  url <- enc2utf8("https://inventaire-forestier.ign.fr/dataifn/data/export_dataifn_2021.zip")

  if (all){
    url <- enc2utf8("https://inventaire-forestier.ign.fr/dataifn/data/export_dataifn_2005_2021.zip")
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
#' \dontrun{
#' get_dataset_names()
#' get_dataset_names()[1]
#' }
get_dataset_names <- function(){
  c("arbre", "bois_mort", "couvert", "ecologie", "flore", "habitat",
    "placette")
}

#' @title get_ifn_all
#' @description
#' Wrapper function to load all ifn datasets
#'
#' @usage get_ifn_all(unlist = T)
#'
#' @param unlist `boolean`; if TRUE, all datasets are load into globalenv. if
#' FALSE, a list of datasets is returned.
#'
#' @return `NULL` or `list`
#' @export
get_ifn_all <- function(unlist = T){

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
