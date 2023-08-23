test_that("get_url works", {
  expect_true(grepl("dataifn_2021", get_url()))
  expect_true(grepl("dataifn_2005_2021", get_url(all = T)))
})

test_that("get_dataset_names works", {
  expect_equal(length(get_dataset_names()), 7)
  expect_equal(get_dataset_names(),
              c("arbre", "bois_mort", "couvert", "ecologie", "flore",
                "habitat","placette"))
})
