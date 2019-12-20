## Dae Hyun Lee
## MA615 
# Data Cleaning and Wrangling Process
#
#-----------------------------------------------------------------------------------------
pacman::p_load("ggplot2","tidyverse","dplyr","tidyr","tinytex","magrittr","DT","readxl",
               "shiny","shinydashboard","plotly","readxl","abind","gridExtra","scales",
               "leaflet", "RColorBrewer", "scales", "lattice")
#-----------------------------------------------------------------------------------------
# Read csv file.
# review data contain the review comments for the Airbnb listings.
# listing file 

# Boston
bos_review <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/Boston/reviews-1.csv")
bos_cal <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/Boston/calendar.csv")
bos_list <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/Boston/listings.csv")
bos_nei <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/Boston/neighbourhoods.csv")

# NYC
ny_review <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/NYC/reviews-1.csv")
ny_cal <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/NYC/calendar.csv")
ny_list <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/NYC/listings.csv")
ny_nei <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/NYC/neighbourhoods.csv")

# Hawaii
hawa_review <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/Hawaii/reviews-1.csv")
hawa_cal <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/Hawaii/calendar.csv")
hawa_list <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/Hawaii/listings.csv")
hawa_nei <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/Hawaii/neighbourhoods.csv")

# LA
la_review <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/LA/reviews-1.csv")
la_cal <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/LA/calendar.csv")
la_list <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/LA/listings.csv")
la_nei <- read_csv("/Users/daylelee/Desktop/MA615_proj_f/Data/LA/neighbourhoods.csv")

#-----------------------------------------------------------------------------------------
# Select the variables of my interest.
#-----------------------------------------------------------------------------------
bos_list <- bos_list %>%
  select(
    list_id = id,
    list_name = name,
    host_id,
    host_name,
    neighbourhood,
    lat = latitude,
    lon = longitude,
    room_type,
    price,
    number_of_reviews,
    reviews_per_month,
    host_listings = calculated_host_listings_count
  ) %>%
  mutate(region = "BOS")

ny_list <- ny_list %>%
  select(
    list_id = id,
    list_name = name,
    host_id,
    host_name,
    neighbourhood,
    lat = latitude,
    lon = longitude,
    room_type,
    price,
    number_of_reviews,
    reviews_per_month,
    host_listings = calculated_host_listings_count
  ) %>%
  mutate(region = "NYC")

la_list <- la_list %>%
  select(
    list_id = id,
    list_name = name,
    host_id,
    host_name,
    neighbourhood,
    lat = latitude,
    lon = longitude,
    room_type,
    price,
    number_of_reviews,
    reviews_per_month,
    host_listings = calculated_host_listings_count
  ) %>%
  mutate(region = "LA")

hawa_list <- hawa_list %>%
  select(
    list_id = id,
    list_name = name,
    host_id,
    host_name,
    neighbourhood,
    lat = latitude,
    lon = longitude,
    room_type,
    price,
    number_of_reviews,
    reviews_per_month,
    host_listings = calculated_host_listings_count
  ) %>%
  mutate(region = "HAWA")

# Combine the four datasets into one.
com_list <- rbind(bos_list, ny_list, la_list, hawa_list)
#-------------------------------------------------------------------
# Save listing data as RDATA and csv
save(bos_list, file = "bos_data_list.RData")
write.csv(bos_list, file = "bos_data_list.csv")
save(ny_list, file = "ny_data_list.RData")
write.csv(ny_list, file = "ny_data_list.csv")
save(la_list, file = "la_data_list.RData")
write.csv(la_list, file = "la_data_list.csv")
save(hawa_list, file = "hawa_data_list.RData")
write.csv(hawa_list, file = "hawa_data_list.csv")
#--------------------------------------------------------------------
save(com_list, file = "combined_data_list.RData")
write.csv(com_list, file = "combined_data_list.csv")
#--------------------------------------------------------------------
########## TOO BIG ############### REVIEW DATA
save(bos_review, file = "bos_data_review.RData")
save(la_review, file = "la_data_review.RData")
save(ny_review, file = "ny_data_review.RData")
save(hawa_review, file = "hawa_data_review.RData")
# subset review data -----------------------------------------------
# because it takes too long to run the shiny application with the whole datasets. 
bos_review2 <- bos_review %>% sample_n(3000)
ny_review2 <- ny_review %>% sample_n(3000)
la_review2 <- la_review %>% sample_n(3000)
hawa_review2 <- hawa_review %>% sample_n(3000)
# save data_review2 for all four cities-----------------------------
save(bos_review2, file = "bos_data_review2.RData")
save(la_review2, file = "la_data_review2.RData")
save(ny_review2, file = "ny_data_review2.RData")
save(hawa_review2, file = "hawa_data_review2.RData")
write.csv(bos_review2, file = "bos_data_review2.csv")
write.csv(la_review2, file = "la_data_review2.csv")
write.csv(ny_review2, file = "ny_data_review2.csv")
write.csv(hawa_review2, file = "hawa_data_review2.csv")
#--------------------------------------------------------------------



