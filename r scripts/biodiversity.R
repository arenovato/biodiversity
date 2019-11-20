#downlaoding GBFI
install.packages('spocc')
library(spocc)
library(mapr)
library(raster)
library(ggplot2)

spdist <- occ(query='Crotalus horridus', from='gbif')
#look for S4 Class
spdist$gbif$data

#convert to data frame 
spdist_df = occ2df(spdist)

print(spdist) ## Not obvious what or where the data are
View(spdist)
df = as.data.frame(occ2df(spdist$gbif))

install.packages('mapr')

map_leaflet(spdist)
map_leaflet(df)
map_leaflet(df[,c('name', 'longitude', 'latitude', 'locality' , 'stateProvince', 'country', 'year', 'occurrenceID')])

nrow(df)
spdist2 <- occ(query='Crotalus horridus', limit=2500)
map_leaflet(spdist2)

wc = getData('worldclim', var='bio', res = 5)

  
ext = extent(-125, -55, 20, 60)
wc = crop(wc, ext)

wc_df = as.data.frame(wc, xy=TRUE)
sp_df = occ2df(spdist2)
ggplot() +
  geom_raster(data = wc_df, aes(x = x, y = y, fill = bio1/10)) +
  geom_point(data=sp_df, aes(x=longitude, y=latitude), col='white') +
  coord_quickmap() +
  theme_bw() + 
  scale_fill_gradientn(colours=c('navy', 'darkred'),
                       na.value = "black")

extr = extract(wc, sp_df[,c('longitude', 'latitude')])
summary(extr)

extr=as.data.frame(na.omit(extr))

ggplot(data=extr) +
  geom_histogram(aes(x=bio12), bins=30) + 
  theme_bw()




