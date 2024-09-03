# test for dir = character and dir = NULL
# test for quiet argument

test_that("get_ifn_metadata works from internet", {
  skip_if_offline()
  skip_on_cran()
  skip_on_ci()

  res <- get_ifn_metadata(dir = NULL, unlist = F, quiet = T)

  expect_equal(class(res), "list")
  expect_equal(length(res), 3)
  expect_equal(names(res), c("code", "units", "units_value_set"))
})

test_that("load_code works from dir", {
  tmp <- tempdir(check = T)
  fake_metadonnees_df <- as.data.frame(matrix(1:400, ncol = 4, nrow = 400))

  write.csv2(fake_metadonnees_df, file.path(tmp, "metadonnees.csv"), row.names = F)

  code <- load_code(tmp, quiet = T)

  expect_equal(class(code), "data.frame")
  expect_equal(dim(code), c(163L, 3L))
  expect_equal(code[1,3], "1818")
  expect_equal(names(code), c("code", "libelle", "definition"))
})

test_that("load_units works from dir", {
  tmp <- tempdir(check = T)
  fake_metadonnees_df <- as.data.frame(matrix(1:400, ncol = 7, nrow = 400))

  write.csv2(fake_metadonnees_df, file.path(tmp, "metadonnees.csv"), row.names = F)

  units <- load_units(tmp, quiet = T)

  expect_equal(class(units), "data.frame")
  expect_equal(dim(units), c(216, 6L))
  expect_equal(names(units),
               c("data", "units", "campagnes", "type", "libelle", "definition"))
})

test_that("load_units works from dir", {
  tmp <- tempdir(check = T)
  fake_metadonnees_df <- as.data.frame(matrix(1:400, ncol = 5, nrow = 400))

  write.csv2(fake_metadonnees_df, file.path(tmp, "metadonnees.csv"), row.names = F)

  units_value_set <- load_units_value_set(tmp, quiet = T)

  expect_equal(class(units_value_set), "data.frame")
  expect_equal(dim(units_value_set), c(20L, 4L))
  expect_equal(names(units_value_set),
               c("units", "code", "libelle", "definition"))
})

