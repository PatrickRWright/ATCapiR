context("translate ATC codes")

test_that("Test fail", {
  expect_error(translate_ATC_codes(1337))
  expect_error(translate_ATC_codes("acharacterstring"))
})
