
load_data <- function(){
  nyt_data <- readr::read_csv("https://raw.githubusercontent.com/alex/nyt-2020-election-scraper/master/battleground-state-changes.csv",
                              col_types = cols())
  nyt_data <- 
    mutate(nyt_data, 
           vote_differential = ifelse(leading_candidate_name == "Biden", 
                                      vote_differential, -vote_differential))
  return(nyt_data)
}
