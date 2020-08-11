#' Helper to create the mapping table and translate the input given to translate_ATC_codes().
#' 
#' @param ATC_codes character vector - ATC codes
#' @param len integer - the length of the ATC code level (7 is the maximum 1 the minimum)
#' @param api_key character - create an account at https://bioportal.bioontology.org/ and it will come with an api key
#' @return data.frame
#' @importFrom stringr str_length
#' @importFrom jsonlite fromJSON
#' @details Since the level depth specified in translate_ATC_codes() needs to be translated
#'          to a string length, this helper was written to perform this task in a controled manner.
#' @examples
#' \dontrun{
#' ATC_vect <- c("A02BC02", "C03BA08", "A02BC02", "A02BC02", "A07DA03", "A07DA03",
#'               "A02BC02", "A02BC02", "A02BC02", "A02BC02", "C10AA05", "C10AA05",
#'               "C10AA05", "N05BA06", "N05BA06", "N05BA06", "N06AX11", "N06AX11")
#' # you will need to create an account at https://bioportal.bioontology.org/
#' # to receive an api_key
#' ATCapiR:::map_ATC_to_text(ATC_vect, len = 7, api_key = api_key)
#' }
map_ATC_to_text <- function(ATC_codes, len = 7, api_key) {
  api_link <- "http://data.bioontology.org/search?ontologies=ATC&require_exact_match=true&q="
  # get relevant substring
  ATC_codes_trunc <- substr(ATC_codes, start = 1, stop = len)
  
  # warn before removal of invalid (too short) IDs
  len_in_vect <- length(ATC_codes_trunc)
  wrong_length_idx <- which(str_length(ATC_codes_trunc) != len)
  len_wrong_length <- length(wrong_length_idx)
  if (len_wrong_length) {
    warning(paste0(len_wrong_length, " of your ", len_in_vect,
                   " input codes are/is not ", len,
                   " characters long and will be",
                   " removed before the translation."))
  }
  
  # retain only codes with valid length
  ATC_codes_trunc_valid <- ATC_codes_trunc[which(str_length(ATC_codes_trunc) == len)]
  uniq_ATC_set_vect <- unique(ATC_codes_trunc_valid)
  uniq_ATC_set_df <- as.data.frame(uniq_ATC_set_vect)
  uniq_ATC_set_df$name <- NA
  names(uniq_ATC_set_df)[1] <- "code"
  # query API for each code
  for (i in 1:nrow(uniq_ATC_set_df)) {
    curr_code <- uniq_ATC_set_df$code[i]
    full_api_link <- paste0(api_link, curr_code, "&apikey=", api_key)
    json_df <- fromJSON(full_api_link)
    if(length(json_df$collection)) {
      uniq_ATC_set_df$name[i] <- json_df$collection$prefLabel
    }
  }
  # translate input
  ATC_codes_mapped <- as.data.frame(cbind(ATC_codes_trunc_valid, ATC_codes_trunc_valid))
  names(ATC_codes_mapped) <- c("code", "name")
  ATC_codes_mapped$name <- uniq_ATC_set_df$name[match(ATC_codes_mapped$code, uniq_ATC_set_df$code)]
  return(ATC_codes_mapped)
}
