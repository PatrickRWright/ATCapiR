<!-- README.md is generated from README.Rmd. Please edit that file -->

ATCapiR [![](https://img.shields.io/badge/dev%20version-0.0.1-blue.svg)](https://github.com/PatrickRWright/ATCapiR) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/PatrickRWright/ATCapiR?branch=master&svg=true)](https://ci.appveyor.com/project/PatrickRWright/ATCapiR) [![travis](https://api.travis-ci.com/PatrickRWright/ATCapiR.svg?branch=master)](https://api.travis-ci.com/PatrickRWright/ATCapiR.svg?branch=master) [![codecov](https://codecov.io/github/PatrickRWright/ATCapiR/branch/master/graphs/badge.svg)](https://codecov.io/github/PatrickRWright/ATCapiR)
============================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================

Before you install
------------------

I you would like to work with this package you will first need to create
a personal account at the [NCBI
Bioportal](https://bioportal.bioontology.org/). Withing your account
information you should be able to find an API key. Only a valid API key
will allow you to use the package.

Installing from GitHub with devtools
------------------------------------

    devtools::install_github("PatrickRWright/ATCapiR")

Basic usage
-----------

Load the package

    # load the package
    library(ATCapiR)
    # vector of ATC codes
    ATC_vect <- c("A02BC02", "C03BA08", "A02BC02", "A02BC02", "A07DA03", "A07DA03",
                  "A02BC02", "A02BC02", "A02BC02", "A02BC02", "C10AA05", "C10AA05",
                  "C10AA05", "N05BA06", "N05BA06", "N05BA06", "N06AX11", "N06AX11")
    # you will need to create an account at https://bioportal.bioontology.org/ to receive an api_key
    # the key below is not real and just supposed to give you an impression of the format
    api_key <- "a123b456-cd78-91e2-fgh3-4ij56kl7mno8"
    # return translation at third level resolution
    ATC_translated_df <- translate_ATC_codes(ATC_vect, level_depth = 3, api_key = api_key)

If `HTTP error 401` is returned your API key is likely wrong or void.

For contributors
----------------

### Testing with devtools

    # run tests, this assumes you are one directory up from the ATCapiR dir
    devtools::test("ATCapiR")
    # spell check
    # ignore words character vector allows to exclude technical terms in the check
    ignore_words <- c()
    devtools::spell_check("ATCapiR", ignore = ignore_words)

### Linting with lintr

    # lint the package -> should be clean
    library(lintr)
    lint_package("ATCapiR", linters = with_defaults(camel_case_linter = NULL,
                                                         object_usage_linter = NULL,
                                                         line_length_linter(125)))

### Building the vignette

    library(rmarkdown)
    render("vignettes/ATCapiR-package-vignette.Rmd",
           output_format=c("pdf_document"))

### Generating the README file

The README file contains both standard text and interpreted R code.
Changes should be made in the `README.Rmd` file and the file “knited”
with R. In this template the knitting of the Rmd file is performed
automatically with GitHub actions.

### Handling dependencies

Dependencies to other R packages are to be declared in the `DESCRIPTION`
file under `Imports:` and in the specific `roxygen2` documentation of
the functions relying on the dependency. It is suggested to be as
explicit as possible. i.e. Just import functions that are needed and not
entire packages.

Example to import `str_match` `str_length` `str_wrap` from the `stringr`
package:

    #' @importFrom stringr str_match str_length str_wrap

### Preparing a release on CRAN

    # build the package archive
    R CMD build ATCapiR
    # check the archive (should return "Status: OK", no WARNINGs, no NOTEs)
    # in this example for version 0.0.1
    R CMD check ATCapiR_0.0.1.tar.gz

### Guidelines for contributors

Requests for new features and bug fixes should first be documented as an
[Issue](https://github.com/) on GitHub. Subsequently, in order to
contribute to this R package you should fork the main repository. After
you have made your changes please run the
[tests](README.md#testing-with-devtools) and
[lint](README.md#linting-with-lintr) your code as indicated above.
Please also increment the version number. If all tests pass and linting
confirms that your coding style conforms you can send a pull request
(PR). Changes should also be mentioned in the `NEWS` file. A test has
been implemented to remind you to make these changes (see
[here](tests/testthat/test-version_diff.R)). The PR should have a
description to help the reviewer understand what has been added/changed.
New functionalities must be thoroughly documented, have examples and
should be accompanied by at least one [test](tests/testthat/) to ensure
long term robustness. The PR will only be reviewed if all travis,
AppVeyor and GitHub actions checks are successful. The person sending
the PR should not be the one merging it.
