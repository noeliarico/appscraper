#' @export
appscraper_npm_install <- function(
  force = FALSE
){
  # Prompt the users unless they bypass (we're installing stuff on their machine)
  if (!force) {
    ok <- yesno::yesno("This will install our app on your local library.
                       Are you ok with that? ")
  } else {
    ok <- TRUE
  }

  # If user is ok, run npm install in the node folder in the package folder
  # We should also check that the infra is not already there
  if (ok){
    processx::run(
      command = "npm",
      args = c("install", "google-play-scraper"),
      wd = system.file("node", package = "appscraper")
    )
  }
}
