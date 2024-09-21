#' check_happifndata
#'
#' @param version `character`; version of `happifndata` to check
#'
#' @importFrom utils packageVersion installed.packages
#'
#' @export
#'
#' @returns No return value, called for check and fix installation
#' of `happifndata`
#'
#' @examples
#' \donttest{
#' check_happifndata()
#' }
#'
check_happifndata <- function(version = "0.0.0.9000") {

  if (!requireNamespace("happifndata", quietly = TRUE)) {
    message("The happifndata package needs to be installed.")
    install_happifndata()

  }else if(packageVersion("happifndata") < version) {
    message("The happifndata package needs to be updated.")
    install_happifndata()
  }
}

#' install_happifndata
#'
#' @returns No return value, called for check and fix installation
#' of `happifndata`
#' @noRd
install_happifndata <- function(){

  instructions <- paste("Please try installing the package using the",
                        "following command:\n",
                        "devtools::install_github(\"paul-carteron/happifndata\")")

  input <- 1
  if (interactive()) {
    input <- utils::menu(c("Yes", "No"),
                         title = "Install the happifndata package?"
    )
  }

  if (input == 1){
    tryCatch({
      message("Installing the happifndata package.")
      devtools::install_github("paul-carteron/happifndata")
    },
    error = function(e) {
      stop("Failed to install the happifndata package.\n", instructions, call. = FALSE)
    })
  }else{
    stop("The happifndata package is necessary for that method.\n", instructions)
  }
}

