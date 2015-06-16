library(stringr)

scrub_boilerplate <- function(name) {
  for(pattern in boilerplate_patterns) {
    name <- str_replace_all(name, regex(pattern, ignore_case= TRUE), "")
  }
  str_trim(name)
}

prepare_str_for_matching <- function(str) {
  tolower(str_replace_all(str, "[— '.,-]", ""))
}

# regexs representing boilerplate in party riding names
boilerplate_patterns <- c(
  "(liberal)|(lib.rale)",
  "(conservative)|(cpc)|(Conservateur)",
  "(ndp)|(npd)|(new democratic)",
  "bloc Qu..?b.cois",
  "(greens?)|(gpc)|(Parti Vert)",
  "federal",
  "f.d.rale",
  "party",
  "(du )?parti",
  "riding",
  "electoral district",
  " eda",
  "Association of the",
  "(l')?association( du)?",
  "(de )?(la )?Circonscription( du)?",
  "Pour La",
  "of canada",
  ",",
  "du canada",
  "constituency",
  "Comt. ",
  "pour ",
  "^ *(d|l)'",
  "^ *the +",
  "^ *du +",
  " +du *$",
  "^ *de +",
  "^ *(d|l)'",
  "^ *of +"
)