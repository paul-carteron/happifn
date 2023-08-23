test_that("get_ifn errors", {
  expect_error(get_ifn("bad_name"), "'dataset' should")
})

test_that("load_ifn works from dir", {
  tmp <- tempdir(check = T)
  write.csv2(data.frame(id = 1), file.path(tmp, "HABITAT.csv"), row.names = F)

  res <- load_ifn("HABITAT", dir = tmp)
  expect_equal(res, data.frame(id = 1))
})

test_that("load_ifn works without dir", {
  skip_if_offline()

  res <- load_ifn("HABITAT", dir = NULL)
  expect_equal(class(res), "data.frame")
  expect_equal(dim(res), c(1815L, 14L))
})

test_that("get_ifn works", {
  skip_if_offline()

  res <- get_ifn("habitat")
  expect_null(res)

  expect_warning(get_ifn("habitat"),
                 "not loaded because already in the environment.")
})
