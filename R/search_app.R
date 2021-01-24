# Apple -------------------------------------------------------------------

#' Search in App Store
#'
#' Return the list obtaining for searching the text giving as parameter
#'
#' @param term      word(s) to search apps about
#' @param country   market where the user desired to search the app
#' @param platform  any, iPhone, iPad or iMac
#'
#'
#' @return tibble with the apps found for the search
#'
#' @export
search_app_apple <- function(term, country = "es", platform = "software") {

  # "https://itunes.apple.com/search?term=angry+birds&entity=software,iPadSoftware,macSoftware
  term <- stringr::str_replace_all(term," ", "+")
  query <- paste0("https://itunes.apple.com/search?term=", term,"&entity=software&country=", country)
  print(query)
  res <- httr::GET(query)
  httr::stop_for_status(res)
  res <- jsonlite::fromJSON(httr::content(res, as = 'text', encoding = 'UTF-8'), flatten = TRUE)
  res <- tibble::as_tibble(res$results)
  return(res)

  query <- paste0("https://play.google.com/store/search?q=shazam")

}


# Android -----------------------------------------------------------------

#' Search in Google Play
#'
#' Retrieves a list of apps in Google Play that results of searching by the
#' given term.
#'
#' @param term  the term to search by
#' @param num optional the amount of apps to retrieve. defaults to 20, max is 250):
#' @param lang (optional, defaults to 'en'): the two letter language code used to retrieve the applications.
#' @param country (optional, defaults to 'us'): the two letter country code used to retrieve the applications.
#' @param fullDetail (optional, defaults to false): if true, an extra request will be made for every resulting app to fetch its full detail.
#' @param price (optional, defaults to all): allows to control if the results apps are free, paid or both.
#'\itemize{
##'  \item{"all": }{Free and paid}
##'  \item{"free": }{Free apps only}
##'  \item{"paid": }{Paid apps only}
##' }
##'
#' @return tibble containing the information of the apps retrieved in the search
#' \itemize{
#' \item \code{title} - Full name of the app in Google Play
#' \item description
#' \item descriptionHTML
#' \item summary
#' \item \code{installs} - Number of times installed
#' \item minInstalls
#' \item maxInstalls
#' \item \code{score}
#' \item \code{scoreText}
#' \item \code{ratings} - Number of rating used to compute the score
#' \item \code{reviews} - Number of reviews
#' \item \code{histogram}
#' \item \code{price} - Price of the app
#' \item \code{free} - Boolean value
#' \item \code{currency} - Currency of the price in the corresponding market
#' \item \code{priceText} - "Free" if price = 0
#' \item \code{offersIAP} - Boolean
#' \item \code{IAPRange} - If offersIAP is FALSE, this is NA
#' \item \code{size} - "Varies with device"
#' \item \code{androidVersion} - "VARY"
#' \item \code{androidVersionText} - "Varies with device"
#' \item \code{developer} - Developer's name
#' \item \code{developerId} - Developer's username
#' \item \code{developerEmail} - Developer's email
#' \item \code{developerWebsite} - Developer's webiste
#' \item \code{developerAddress} - Developer's physical address
#' \item \code{privacyPolicy} - Terms of privacy
#' \item \code{developerInternalID} - Number
#' \item \code{genre} - "Music & Audio"
#' \item \code{genreId} - "MUSIC_AND_AUDIO"
#' \item familyGenre NULL
#' \item familyGenreId NULL
#' \item \code{icon} - URL to the icon of the app
#' \item \code{headerImage} - URL to the header image of the app shown in Google Play
#' \item \code{screenshots} - URL to the screenshot shown in the descriptions
#' \item video NULL
#' \item videoImage NULL
#' \item \code{contentRating} - Teen
#' \item \code{contentRatingDescription} - NA
#' \item \code{adSupported} - Boolean FALSE
#' \item \code{released}
#' \item updated
#' \item version Varies with device
#' \item recentChanges text description with changes
#' \item \code{comments} - List with the comments left by the users
#' \item \code{editorsChoice} - Boolean
#' \item \code{appId} - id of the app in the form of com._....
#' \item \code{url} - URL used to get the information
#' }
#'
#' @export
#'
#' @examples
search_app_google <- function(term,
                              num = 20,
                              lang = "en",
                              country = "us",
                              fullDetail = FALSE,
                              price = "all") {
  term <- stringr::str_replace_all(term," ", "+")
  res <- processx::run(
    command = "node",
    args = c(
      "search.js",
      input = c(term, "20", lang, country, "FALSE", price)
    ),
    wd = system.file("node", package = "appscraper")
  )
  res <- jsonlite::fromJSON(res$stdout)
  res <- tibble::as_tibble(res)
  return(res)
}
