

library(here, quietly = TRUE)
library(tidyverse, quietly = TRUE)
library(rmapshaper, quietly = TRUE)
library(sf, quietly = TRUE)
library(janitor, quietly = TRUE)
library(sfislands, quietly = TRUE)
library(spdep, quietly = TRUE)



## Data preparation

### Voting data 2017-2024

# SOURCE: https://ckan.publishing.service.gov.uk/dataset/westminster-parliamentary-constituencies-december-2019-boundaries-uk-bfe1/resource/a13d5188-2a5d-4867-a93d-509ea4235299

# constituencies in 2017 and 2019
# this file too large to upload to github
# have uploaded a simplified version
# constituencies19 <- st_read(here("data-raw","boundaries","Westminster_Parliamentary_Constituencies_Dec_2019_Boundaries_UK_BFE_2022_5896292250094173431.geojson"), quiet = TRUE) |> 
#   select(pcon19cd,pcon19nm,geometry) |> 
#   rename(con_name = pcon19nm,
#          con_code = pcon19cd) |> 
#   ms_simplify(keep = 0.1)
# 
# saveRDS(constituencies19, here("data-raw","boundaries","constituencies19"))

constituencies19 <- readRDS(here("data-raw","boundaries","constituencies19"))


# projection data to 2024

# SOURCE: https://commonslibrary.parliament.uk/boundary-review-2023-which-seats-will-change/

all_changes <- readxl::read_xlsx(here("data-raw","boundaries","Boundary_changes_data_file.xlsx"), 
                                 sheet = 3, skip = 1)

projection_df <- all_changes |> 
  select(1:4,9,11) |> 
  rename(prop_old_in_new = `Percentage of old constituency in this segment (population) [notes 1 and 2]`) |> 
  # make alterations for Scottish constituencies with different codes in 2024
  # none of these constituencies have had their boundaries moved
  # just changing code manually
  mutate(`New constituency code` = case_when(`New constituency code` == "S14000006" ~ "S14000107",
                                             `New constituency code` == "S14000008" ~ "S14000108",
                                             `New constituency code` == "S14000010" ~ "S14000109",
                                             `New constituency code` == "S14000040" ~ "S14000110",
                                             `New constituency code` == "S14000058" ~ "S14000111",
                                             TRUE ~ `New constituency code`)) |> 
  mutate(`Current constituency code` = case_when(`Current constituency code` == "S14000006" ~ "S14000107",
                                                 `Current constituency code` == "S14000008" ~ "S14000108",
                                                 `Current constituency code` == "S14000010" ~ "S14000109",
                                                 `Current constituency code` == "S14000040" ~ "S14000110",
                                                 `Current constituency code` == "S14000058" ~ "S14000111",
                                                 TRUE ~ `Current constituency code`))



# 2017 votes

# SOURCE: https://researchbriefings.files.parliament.uk/documents/CBP-7979/HoC-GE2017-results-by-constituency.csv

votes17 <- read.csv(here("data-raw","election_results","HoC-GE2017-results-by-constituency.csv")) |> 
  clean_names() |> 
  left_join(constituencies19 |> select(con_code,geometry),
            by = c("ons_id"="con_code")) |> 
  rename(con_code = ons_id) |> 
  rename(other = all_other_candidates) |> 
  rename(ruk = ukip) |> 
  select(con_code,constituency_name,region_name,majority,valid_votes,con:other,geometry) |> 
  rename(valid_votes17 = valid_votes) |> 
  mutate(con_code = case_when(con_code == "S14000006" ~ "S14000107",
                              con_code == "S14000008" ~ "S14000108",
                              con_code == "S14000010" ~ "S14000109",
                              con_code == "S14000040" ~ "S14000110",
                              con_code == "S14000058" ~ "S14000111",
                              TRUE ~ con_code),
         con_code = factor(con_code),
         constituency_name = factor(constituency_name),
         region_name = factor(region_name)) |> 
  st_as_sf()

# 2017 votes projected to 2024 constituencies
votes17proj <- votes17 |> 
  select(con_code,con:other) |> 
  st_drop_geometry() |> 
  pivot_longer("con":"other") |> 
  left_join(projection_df,
            by = c("con_code"="Current constituency code"),
            relationship = "many-to-many") |> 
  mutate(value = prop_old_in_new * value) |> 
  select(name,value,`New constituency name`,`New constituency code`) |> 
  rename(constituency_name = `New constituency name`, 
         newcon_code = `New constituency code`) |> 
  group_by(newcon_code, name) |> 
  summarise(value = sum(value) |> round()) |> 
  pivot_wider(names_from = "name",values_from = "value") |> 
  rowwise() |> 
  mutate(
    first_party17 = factor(colnames(across(apni:uup))[which.max(c_across(apni:uup))]), 
    second_party17 = factor(colnames(across(apni:uup))[order(-c_across(apni:uup))[2]]), 
    third_party17 = factor(colnames(across(apni:uup))[order(-c_across(apni:uup))[3]]),
  ) |> 
  ungroup() |> 
  rename_with(~ paste0(.x, "17"), apni:uup) |>
  mutate(valid_votes17 = rowSums(across(apni17:uup17), na.rm = TRUE)) |> 
  mutate(across(apni17:uup17, ~ .x / valid_votes17 * 100, .names = "{.col}_pct")) |> 
  rename(con_code = newcon_code) |> 
  mutate(con_code = factor(con_code),
         across(apni17:uup17, as.integer),
         valid_votes17 = as.integer(valid_votes17)) |> 
  # for speaker seat, Chorley (E14001170), make all positions stay as speaker
  mutate(first_party17 = if_else(con_code == "E14001170", "spk", first_party17),
         second_party17 = if_else(con_code == "E14001170", "spk", second_party17),
         third_party17 = if_else(con_code == "E14001170", "spk", third_party17))

# 2019 votes

# SOURCE: https://researchbriefings.files.parliament.uk/documents/CBP-8749/HoC-GE2019-results-by-constituency.csv

votes19 <- read.csv(here("data-raw","election_results","HoC-GE2019-results-by-constituency.csv")) |> 
  clean_names() |> 
  left_join(constituencies19 |> select(con_code,geometry),
            by = c("ons_id"="con_code")) |> 
  rename(con_code = ons_id) |> 
  rename(other = all_other_candidates) |> 
  rename(ruk = brx) |> 
  select(con_code,constituency_name,region_name,majority,valid_votes,con:other,geometry) |>  
  rename(valid_votes19 = valid_votes) |> 
  mutate(con_code = case_when(con_code == "S14000006" ~ "S14000107",
                              con_code == "S14000008" ~ "S14000108",
                              con_code == "S14000010" ~ "S14000109",
                              con_code == "S14000040" ~ "S14000110",
                              con_code == "S14000058" ~ "S14000111",
                              TRUE ~ con_code),
         con_code = factor(con_code),
         constituency_name = factor(constituency_name),
         region_name = factor(region_name)) |> 
  st_as_sf()

# 2019 votes projected to 2024 constituencies
votes19proj <- votes19 |> 
  select(con_code,con:other) |> 
  st_drop_geometry() |> 
  pivot_longer("con":"other") |> 
  left_join(projection_df,
            by = c("con_code"="Current constituency code"),
            relationship = "many-to-many") |> 
  mutate(value = prop_old_in_new * value) |> 
  select(name,value,`New constituency name`,`New constituency code`) |> 
  rename(constituency_name = `New constituency name`, 
         newcon_code = `New constituency code`) |> 
  group_by(newcon_code, name) |> 
  summarise(value = sum(value) |> round()) |> 
  pivot_wider(names_from = "name",values_from = "value") |> 
  rowwise() |> 
  mutate(
    first_party19 = factor(colnames(across(apni:uup))[which.max(c_across(apni:uup))]), 
    second_party19 = factor(colnames(across(apni:uup))[order(-c_across(apni:uup))[2]]), 
    third_party19 = factor(colnames(across(apni:uup))[order(-c_across(apni:uup))[3]])
  ) |> 
  ungroup() |> 
  rename_with(~ paste0(.x, "19"), apni:uup) |>
  mutate(valid_votes19 = rowSums(across(apni19:uup19), na.rm = TRUE)) |> 
  mutate(across(apni19:uup19, ~ .x / valid_votes19 * 100, .names = "{.col}_pct"))|> 
  rename(con_code = newcon_code) |> 
  mutate(con_code = factor(con_code),
         across(apni19:uup19, as.integer),
         valid_votes19 = as.integer(valid_votes19)) |> 
  # for speaker seat, Chorley (E14001170), make all positions stay as speaker
  mutate(first_party19 = if_else(con_code == "E14001170", "spk", first_party19),
         second_party19 = if_else(con_code == "E14001170", "spk", second_party19),
         third_party19 = if_else(con_code == "E14001170", "spk", third_party19))



## Boundaries for constituencies and regions 2024

# SOURCE hex: https://observablehq.com/@jwolondon/uk-election-2024-boundary-data
# SOURCE regular: https://geoportal.statistics.gov.uk/maps/ons::westminster-parliamentary-constituencies-july-2024-boundaries-uk-buc-2

constituencies24 <- 
  st_read(here("data-raw","boundaries","Westminster_Parliamentary_Constituencies_July_2024_Boundaries_UK_BUC_4872633423108313063.geojson"), quiet = TRUE) |> 
  select(PCON24CD,PCON24NM,geometry) |> 
  rename(con_name = PCON24NM,
         con_code = PCON24CD) |> 
  mutate(con_name = factor(con_name),
         con_code = factor(con_code)) |> 
  left_join(hex24 |> st_drop_geometry())

hex24 <- st_read(here("data-raw","boundaries","hexConstituencies.json"), quiet = TRUE) |> 
  select(PCON24CD,PCON24NM,name3,regionNM,geometry) |> 
  rename(con_name = PCON24NM,
         con_code = PCON24CD,
         reg_name = regionNM,
         con_abb = name3) |> 
  mutate(con_name = factor(con_name),
         con_code = factor(con_code),
         reg_name = factor(reg_name),
         con_abb = factor(con_abb))

regions24 <- constituencies24 |> 
  ms_dissolve("reg_name") |> 
  mutate(reg_name = factor(
    case_when(reg_name == "Greater London" ~ "London",
                              reg_name == "Yorkshire and the Humber" ~ "Yorkshire and The Humber",
                              TRUE ~ reg_name)))


hexregions24 <- hex24 |> 
  ms_dissolve("reg_name")

hexoutline24 <- hex24 |> 
  ms_dissolve()

# 2024 votes

# SOURCE: https://researchbriefings.files.parliament.uk/documents/CBP-10009/HoC-GE2024-results-by-constituency.csv

votes24 <- read.csv(here("data-raw","election_results","HoC-GE2024-results-by-constituency.csv")) |> 
  clean_names() |> 
  left_join(constituencies24 |> select(con_code,con_abb,geometry),
            by = c("ons_id"="con_code")) |> 
  rename(con_code = ons_id,
         other = all_other_candidates) |> 
  mutate(first_party = tolower(first_party),
         second_party = tolower(second_party)) |> 
  select(con_code,constituency_name,region_name,first_party,second_party,con:other,valid_votes,majority,geometry) |> 
  rename(first_party24 = first_party,
         second_party24 = second_party,
         valid_votes24 = valid_votes) |> 
  rowwise() |> 
  mutate(
    third_party24 = colnames(across(con:other))[order(-c_across(con:other))[3]]
  ) |> 
  ungroup() |> 
  rename_with(~ paste0(.x, "24"), con:other) |>
  mutate(valid_votes24 = rowSums(across(con24:other24), na.rm = TRUE)) |> 
  mutate(across(con24:other24, ~ .x / valid_votes24 * 100, .names = "{.col}_pct")) |> 
  st_as_sf() |> 
  select(con_code,constituency_name,region_name,first_party24,second_party24,third_party24,everything(),geometry) |> 
  select(-geometry,everything(),geometry) |> 
  mutate(con_code = factor(con_code),
         constituency_name = factor(constituency_name),
         region_name = factor(region_name),
         first_party24 = factor(first_party24),
         second_party24 = factor(second_party24),
         third_party24 = factor(third_party24),
         valid_votes24 = as.integer(valid_votes24)
         )





### Census data

# SOURCE: https://statistics.ukdataservice.ac.uk/dataset/?q=census+2021&sort=score+desc%2C+metadata_modified+desc&vocab_Area_type=Westminster+Parliamentary+Constituencies

sex_age <- readxl::read_xlsx(here("data-raw","census21","RM121-Sex-By-Age-2021-p19wpc-ONS.xlsx")) |> 
  clean_names() |> 
  group_by(post_2019_westminster_parliamentary_constituencies_code,
           post_2019_westminster_parliamentary_constituencies,
           age_23_categories_code,
           age_23_categories) |> 
  summarise(observation = sum(observation))

population <- sex_age |> 
  group_by(post_2019_westminster_parliamentary_constituencies_code,
           post_2019_westminster_parliamentary_constituencies) |> 
  summarise(pop_tot = sum(observation))

sixteenplus <- sex_age |> 
  filter(age_23_categories_code > 6) |> 
  group_by(post_2019_westminster_parliamentary_constituencies_code,
           post_2019_westminster_parliamentary_constituencies) |> 
  summarise(sixteenplus_tot = sum(observation))

eighteenplus <- sex_age |> 
  filter(age_23_categories_code > 7) |> 
  group_by(post_2019_westminster_parliamentary_constituencies_code,
           post_2019_westminster_parliamentary_constituencies) |> 
  summarise(eighteenplus_tot = sum(observation))

over65 <- sex_age |> 
  filter(age_23_categories_code > 18) |> 
  group_by(post_2019_westminster_parliamentary_constituencies_code,
           post_2019_westminster_parliamentary_constituencies) |> 
  summarise(over65_tot = sum(observation))


education <- readxl::read_xlsx(here("data-raw","census21","TS067-Highest-Level-Of-Qualification-2021-p19wpc-ONS.xlsx")) |> 
  clean_names()
education <- education[education[,3] == "5",] |> 
  rename(degree_tot = observation) |> 
  select(1,2,degree_tot)

disability <- readxl::read_xlsx(here("data-raw","census21","TS038-Disability-2021-p19wpc-ONS.xlsx")) |> 
  clean_names()
# disability <- disability[disability[,3] == 1 | disability[,3] == 2,] |>  # limited a little or a lot
disability <- disability[disability[,3] == 1,] |> # limited a lot
  rename(disability_tot = observation) |> 
  select(1,2,disability_tot) |> 
  group_by(post_2019_westminster_parliamentary_constituencies_code,
           post_2019_westminster_parliamentary_constituencies) |> 
  summarise(disability_tot = sum(disability_tot))

health <- readxl::read_xlsx(here("data-raw","census21","RM044-General-Health-By-Ns-Sec-2021-p19wpc-ONS.xlsx")) |> 
  clean_names()
health <- health[health[,3] == "3" | health[,3] == "4" | health[,3] == "5",] |> 
  rename(notgoodhealth_tot = observation) |> 
  select(1,2,notgoodhealth_tot) |> 
  group_by(post_2019_westminster_parliamentary_constituencies_code,
           post_2019_westminster_parliamentary_constituencies) |> 
  summarise(notgoodhealth_tot = sum(notgoodhealth_tot))

white <- readxl::read_xlsx(here("data-raw","census21","RM087-National-Identity-By-Ethnic-Group-2021-p19wpc-ONS.xlsx")) |> 
  clean_names()
white <- white |> 
  filter(str_detect(ethnic_group_8_categories, "White")) |> 
  rename(white_tot = observation) |> 
  select(1,2,white_tot) |> 
  group_by(post_2019_westminster_parliamentary_constituencies_code,
           post_2019_westminster_parliamentary_constituencies) |> 
  summarise(white_tot = sum(white_tot))


census <- population |> 
  left_join(sixteenplus) |> 
  left_join(eighteenplus) |> 
  left_join(over65) |> 
  mutate(over65 = over65_tot / pop_tot) |> 
  left_join(education) |> 
  mutate(degree = degree_tot / eighteenplus_tot) |> 
  left_join(disability) |> 
  mutate(disability = disability_tot / pop_tot) |> 
  left_join(health) |> 
  mutate(notgoodhealth = notgoodhealth_tot / pop_tot) |> 
  left_join(white) |> 
  mutate(white = white_tot / pop_tot) |> 
  rename(con_code = post_2019_westminster_parliamentary_constituencies_code) |> 
  select(con_code, over65, degree, notgoodhealth, white, pop_tot) |> 
  data.frame() |> 
  mutate(con_code = factor(con_code),
         pop_tot = as.integer(pop_tot))




### Unite into one data frame

# can all be joined by "con_code" as shown below...


votestogether <- votes24 |>
  left_join(votes19proj, by="con_code") |>
  left_join(votes17proj, by="con_code") |>
  left_join(census, by="con_code") |>
  st_as_sf() |>
  select(-pop_tot) |>
  select(con_code, region_name, constituency_name, first_party24 ,second_party24, third_party24, everything(), -geometry) |>
  select(everything(), geometry)

votestogether_hex <- votestogether |>
  st_drop_geometry() |>
  left_join(hex24, by="con_code") |>
  st_as_sf()


party_palette <- c(
  "con"="#0087DC",
  "lab"="#E4003B",
  "ld"="#FAA61A",
  "ruk"="#12B6CF",
  "green"="#02A95B",
  "snp"="#FDF38E",
  "pc"="#005B54",
  "dup"="#D46A4C",
  "sf"="#326760",
  "sdlp"="#2AA82C",
  "uup"="#48A5EE",
  "apni"="#F6CB2F",
  "other"="gray",
  "ind"="pink",
  "tuv"="#0C3A6A",
  "spk"="black"
)

# demonstration plots

# ggplot(votestogether) +
#   geom_sf(aes(fill=first_party24)) +
#   scale_fill_manual(values = party_palette)
# 
# ggplot(votestogether) +
#   geom_sf(aes(fill=first_party19)) +
#   scale_fill_manual(values = party_palette)
# 
# ggplot(votestogether) +
#   geom_sf(aes(fill=first_party17)) +
#   scale_fill_manual(values = party_palette)
# 
# ggplot(votestogether_hex) +
#   geom_sf(aes(fill=first_party24)) +
#   scale_fill_manual(values = party_palette)
# 
# ggplot() +
#   geom_sf(data=votestogether_hex, aes(fill=second_party19)) +
#   geom_sf(data=hexregions24, fill=NA, colour="black", linewidth=0.5) +
#   geom_sf(data=hexoutline24, fill=NA, colour="black", linewidth=0.5) +
#   scale_fill_manual(values = party_palette)
# 
# ggplot() +
#   geom_sf(data=votestogether_hex, aes(fill=second_party24)) +
#   geom_sf(data=hexregions24, fill=NA, colour="black", linewidth=0.5) +
#   geom_sf(data=hexoutline24, fill=NA, colour="black", linewidth=0.5) +
#   scale_fill_manual(values = party_palette)
#

usethis::use_data(votes17, votes17proj, votes19, votes19proj, votes24, votestogether,
                  votestogether_hex, census, constituencies19, constituencies24,
                  hex24, hexoutline24, hexregions24, party_palette,
                  overwrite = TRUE)
