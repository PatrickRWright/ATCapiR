<!-- README.md is generated from README.Rmd. Please edit that file -->

ATCapiR [![](https://img.shields.io/badge/dev%20version-0.0.1-blue.svg)](https://github.com/PatrickRWright/ATCapiR) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/PatrickRWright/ATCapiR?branch=master&svg=true)](https://ci.appveyor.com/project/PatrickRWright/ATCapiR) [![travis](https://api.travis-ci.com/PatrickRWright/ATCapiR.svg?branch=master)](https://api.travis-ci.com/PatrickRWright/ATCapiR.svg?branch=master) [![codecov](https://codecov.io/github/PatrickRWright/ATCapiR/branch/master/graphs/badge.svg)](https://codecov.io/github/PatrickRWright/ATCapiR)
============================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================

Before you install
------------------

If you would like to work with this package you will first need to
create a personal account at the [NCBI
Bioportal](https://bioportal.bioontology.org/). Withing your account
information you should be able to find an API key. Only a valid API key
will allow you to use the package.

Installing from GitHub with devtools
------------------------------------

    devtools::install_github("PatrickRWright/ATCapiR")

Basic usage
-----------

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
