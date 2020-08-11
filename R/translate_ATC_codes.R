#' Translate  given vector of ATC codes to text
#' 
#' @param ATC_codes character vector - ATC codes
#' @param level_depth integer (1-5) - 1 is the shortest (length 1 char), 5 the longest (length 7 chars) code
#' @param api_key character - create an account at https://bioportal.bioontology.org/ and it will come with an api key
#' @return Returns a data.frame with the valid input ATC codes in the first column (code)
#'         and the textual names in the second column (name)
#' @details Validity of an ID is only judged based on its length after level depth based
#'          truncation. Thus, IDs can never be too long, only too short. IDs which are
#'          not part of the ATC database, will not return results from the bioportal
#'          API and are translated to NA.
#'          
#'          References:
#'          https://en.wikipedia.org/wiki/Anatomical_Therapeutic_Chemical_Classification_System
#'          https://www.ncbi.nlm.nih.gov/pubmed/21672956
#'          https://www.bioontology.org/wiki/BioPortal_Help#Programming_with_the_BioPortal_API
#' @export
#' @examples
#' ATC_vect <- c("A02BC02", "C03BA08", "A02BC02", "A02BC02", "A07DA03", "A07DA03",
#'               "A02BC02", "A02BC02", "A02BC02", "A02BC02", "C10AA05", "C10AA05",
#'               "C10AA05", "N05BA06", "N05BA06", "N05BA06", "N06AX11", "N06AX11")
#' # you will need to create an account at https://bioportal.bioontology.org/
#' # to receive an api_key
#' translate_ATC_codes(ATC_vect, level_depth = 3, api_key = api_key)
translate_ATC_codes <- function(ATC_codes, level_depth = 5, api_key) {
  # error handling
  if (! typeof(ATC_codes) == "character") {
    stop("Please enter a character vector.")
  }
  # specify depth
  if (level_depth == 5) {
    ATC_codes_mapped <- map_ATC_to_text(ATC_codes, len = 7, api_key)
  } else if (level_depth == 4) {
    ATC_codes_mapped <- map_ATC_to_text(ATC_codes, len = 5, api_key)
  } else if (level_depth == 3) {
    ATC_codes_mapped <- map_ATC_to_text(ATC_codes, len = 4, api_key)
  } else if (level_depth == 2) {
    ATC_codes_mapped <- map_ATC_to_text(ATC_codes, len = 3, api_key)
  } else if (level_depth == 1) {
    ATC_codes_mapped <- map_ATC_to_text(ATC_codes, len = 1, api_key)
  } else {
    stop("Select an integer from 1, 2, 3, 4 or 5")
  }
  no_match_in_db <- ATC_codes_mapped$code[which(is.na(ATC_codes_mapped$name))]
  no_match_in_db_string <- paste(unique(no_match_in_db), collapse = ", ")
  if (str_length(no_match_in_db_string)) {
    warning(paste0("The IDs: '", no_match_in_db_string, "' returned no match."))
  }
  return(ATC_codes_mapped)
}
