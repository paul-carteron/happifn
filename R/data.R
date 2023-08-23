delayedAssign("zp", local({
  try(
    sf::read_sf(
      system.file("extdata/ser.gpkg", package = "happifn")
    ),
    silent = TRUE
  )
}))

delayedAssign("ser", local({
  try(
    sf::read_sf(
      system.file("extdata/ser.gpkg", package = "happifn")
    ),
    silent = TRUE
  )
}))

delayedAssign("rfn", local({
  try(
    sf::read_sf(
      system.file("extdata/ser.gpkg", package = "happifn")
    ),
    silent = TRUE
  )
}))

delayedAssign("ser_ar", local({
  try(
    sf::read_sf(
      system.file("extdata/ser.gpkg", package = "happifn")
    ),
    silent = TRUE
  )
}))
