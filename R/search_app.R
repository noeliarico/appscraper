#' Search app
#'
#' Return the list obtaining for searching the text giving as parameter
#'
#' @param term - word(s) to search apps about
#' @param country - market where the user desired to search the app
#' @param platform - any, iPhone, iPad or iMac
#'
#' @return tibble with the apps found for the search
#'
#' @export
search_app <- function(term, country = "es", platform = "software") {

  # "https://itunes.apple.com/search?term=angry+birds&entity=software,iPadSoftware,macSoftware
  term <- stringr::str_replace_all(term," ", "+")
  query <- paste0("https://itunes.apple.com/search?term=", term,"&entity=software&country=", country)
  print(query)
  res <- httr::GET(query)
  httr::stop_for_status(res)
  res <- jsonlite::fromJSON(httr::content(res, as = 'text', encoding = 'UTF-8'), flatten = TRUE)
  res <- tibble::as_tibble(res$results)
  return(res)
}
