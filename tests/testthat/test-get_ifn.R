test_that("get_ifn errors", {

  expect_error(get_ifn("bad_name"), "`name` should be one")
  expect_error(get_ifn(NULL), "`name` should be of length 1")
  expect_error(get_ifn(c("habitat", "arbre")), "`name` should be of length 1")

  expect_error(get_ifn("habitat", dir = 1),
               "`dir` should be of class `character` or `NULL`")
  expect_error(get_ifn("habitat", dir = "bad_dir"),
               "`dir` does not exist. Check with `dir.exists")
})

test_that("load_ifn works from dir", {
  tmp <- tempdir(check = T)
  write.csv2(data.frame(id = 1), file.path(tmp, "HABITAT.csv"), row.names = F)
  expect_true("HABITAT.csv" %in% list.files(tmp))

  habitat <- load_ifn("habitat", dir = tmp, quiet = T)
  expect_equal(habitat, data.frame(id = 1))
})

test_that("load_ifn works without dir", {
  skip_if_offline()
  skip_on_cran()
  skip_on_ci()

  res <- load_ifn("habitat", dir = NULL, quiet = T)
  expect_equal(class(res), "data.frame")
  expect_equal(dim(res), c(3544L, 13L))
})

test_that("load_ifn quiet parameter", {
  skip_if_offline()
  skip_on_cran()
  skip_on_ci()

  expect_message(load_ifn("habitat", dir = NULL, quiet = F)) |> suppressMessages()
  expect_no_message(load_ifn("habitat", dir = NULL, quiet = T))
})

test_that("get_ifn works without dir", {
  skip_if_offline()
  skip_on_cran()
  skip_on_ci()

  res <- get_ifn("habitat", dir = NULL)
  expect_equal(class(res), "data.frame")
  expect_equal(dim(res), c(3544L, 13L))
})

test_that("get_ifn works placette", {
  tmp <- tempdir(check = T)
  write.csv2(data.frame(id = 1, XL = 765793, YL = 6667114),
             file.path(tmp, "PLACETTE.csv"), row.names = F)

  res <- get_ifn("placette", dir = tmp)
  expect_s3_class(res, "sf")
  expect_equal(dim(res), c(1L, 2L))
})
