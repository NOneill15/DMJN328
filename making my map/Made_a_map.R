#how to download data
install.packages("cancensus")
library(cancensus)


options(cancensus.api_key='CensusMapper_f4bd7f63be8e1d19e885fa85b0f70c79')

#Downloaded data from home
census_data <- get_census(dataset='CA16', regions=list(CT="5050151.09"), 
                          vectors=c(), labels="detailed", geo_format=NA, level='DA')



census_data <- get_census(dataset='CA16', regions=list(CT="5050151.09"), 
                          vectors=c("v_CA16_406","v_CA16_407"), 
                          labels="detailed", geo_format="sf", level='DA')

library(sf)

library(ggplot2)

#MAde a map!!!!

ggplot(census_data) + geom_sf(aes(fill = Population))  
