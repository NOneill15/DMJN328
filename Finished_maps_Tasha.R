#how to download data
#install.packages("cancensus")
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
library(tidyverse)
glimpse(census_data)

commute <- get_census(dataset='CA16', regions=list(CT="5050151.09"), 
                          vectors=c("v_CA16_5819","v_CA16_5816","v_CA16_5822","v_CA16_5825","v_CA16_5828"),
                          labels="detailed", geo_format="sf", level='DA')

#rename variables, gather them (PDF), make a map with facet wrap (PDF)


ggplot(commute) + geom_sf(aes(fill = Population)) 

#renaming

commute<-rename(commute, "15 to 29 mins"=`v_CA16_5819: 15 to 29 minutes`)

commute<-rename(commute, "Less than 15 mins"=`v_CA16_5816: Less than 15 minutes`)

commute<-rename(commute, "30 to 40 mins"=`v_CA16_5822: 30 to 44 minutes`)

commute<-rename(commute, "40 to 59 mins"=`v_CA16_5825: 45 to 59 minutes`)

commute<-rename(commute, "60 mins and over"=`v_CA16_5828: 60 minutes and over`)


#Gather

commute%>%gather("minutes", "people", 14:18)-> commute

#how to make a map?? doesn't like the word 'to'???

ggplot(commute, aes(geometry=geometry, fill=people))+
  scale_fill_distiller(palette="Greens")+
  labs(title="Travel time to work in rural Ottawa")+
  geom_sf()+
  facet_wrap(~minutes)

library(tidyverse)

glimpse(commute)
