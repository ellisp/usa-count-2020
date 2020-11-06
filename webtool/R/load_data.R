
load_data <- function(){
  nyt_data <- readr::read_csv("https://raw.githubusercontent.com/alex/nyt-2020-election-scraper/master/battleground-state-changes.csv",
                              col_types = cols())
  return(nyt_data)
}
