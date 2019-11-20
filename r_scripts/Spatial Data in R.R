mkdir newrepo
cd newrepo

mkdir tmp #For stuff you do NOT want to commit to Git (e.g., climate dataa)
mkdir data # for data you do want to keep
mkdir R # for code
mkdir figures # for images and results files
echo "BIO331 Course Repository for Spatial Bioinformatics Unit" > README.md


install.packages('dismo') # Species Distribution Modeling tools
install.packages('raster') # R tools for GIS raster files
install.packages('spocc') # Access species occurrence data from GBIF/iNaturalist
install.packages('ENMeval') # Tuning SDMs
install.packages('mapr') # Quick mapping tools


library(raster)
clim = getData('worldclim', var='bio', res=5) # Download the WorldClim Bioclim data for the world at a 5 arcminute resolution.

summary(clim)

summary(clim[[1]])
#define an 'extent' object.
#eastern US
ext = extent(-74, -69, 40, 45)

#crop
c2 = crop(clim, ext)
plot(c2[[1]]) # Basic plotting 

library(ggplot2)

c2_df = as.data.frame(c2, xy = TRUE)
head(c2_df)
ggplot() +
  geom_raster(data = c2_df, 
              aes(x = x, y = y, fill = bio1)) +
  coord_quickmap()

base = ggplot() +
  geom_raster(data = c2_df, 
              aes(x = x, y = y, fill = bio1/10)) +
  coord_quickmap() +
  theme_bw() 
base + scale_fill_gradientn(colours=c('navy', 'white', 'darkred'),
                            na.value = "black")


library(viridis)
## Loading required package: viridisLite
base + scale_fill_gradientn(colours=viridis(99), 
                            na.value = "black")
base + scale_fill_gradientn(colours=magma(99), 
                            na.value = "black")

library(ggsci) #for expanded colors
ggplot() +
  geom_raster(data = c2_df, 
              aes(x = x, y = y, fill = bio1), colours=viridis::viridis) +
  coord_quickmap() +
  theme_bw() + 
  scale_fill_gsea() 


ggplot() +
  geom_histogram(data = c2_df, 
                 aes(x = bio1))


ggplot() +
  geom_histogram(data = c2_df, 
                 aes(x = bio12)) #Histogram of Mean Precipitation values








