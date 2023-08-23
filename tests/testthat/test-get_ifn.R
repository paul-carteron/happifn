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

  res <- load_ifn("habitat", dir = NULL, quiet = T)
  expect_equal(class(res), "data.frame")
  expect_equal(dim(res), c(1815L, 14L))
})

test_that("load_ifn quiet parameter", {
  skip_if_offline()

  expect_message(load_ifn("habitat", dir = NULL, quiet = F)) |> suppressMessages()
  expect_no_message(load_ifn("habitat", dir = NULL, quiet = T))
})

test_that("get_ifn works without dir", {
  skip_if_offline()

  res <- get_ifn("habitat", dir = NULL)
  expect_equal(class(res), "data.frame")
  expect_equal(dim(res), c(1815L, 14L))
})
