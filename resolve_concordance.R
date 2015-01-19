source("lib/party_name_scrubber.R")

library(stringdist)

party_names <- read.csv(
  "unique_party_riding_names.csv",
  encoding="UTF-8",
  as.is=TRUE
)

 official_names_ids <- read.csv(
  "official_riding_name_id.csv",
  encoding="UTF-8",
  as.is=TRUE
)

scrubbed_party_names <- sapply(party_names$party_riding_name, scrub_boilerplate)

scrubbed_condensed_party_names <- sapply(scrubbed_party_names, prepare_str_for_matching)
condensed_official_names <- sapply(official_names_ids$riding_name, prepare_str_for_matching)

nearest_name_index <-
  amatch(scrubbed_condensed_party_names, condensed_official_names, maxDist=2)

party_names$riding_name <- official_names_ids$riding_name[nearest_name_index]

concordance <- merge(party_names, official_names_ids, all.x=TRUE)
concordance <- concordance[, c("party_riding_name", "riding_name", "riding_id")]

write.csv(
  concordance,
  file="patry_to_official_riding_name_concordance.csv",
  row.names=FALSE
)