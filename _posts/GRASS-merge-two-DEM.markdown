GRASS-GIS is an open sources software for geographic data processing.
I would like to share my experience on this blog on GRASS data process.

I have downloaded the NED (national elevation data) from USGS. However,
all NED data is one degree by one degree square while my basin between
two squares. I have to merge two NED so as to get the completely basin
DEM info.

The idea is crop the DEM and then merge together

The NDE data are n38w120 and n39w120. I my basin range is 
(119:02:55, 119:57:40)West and (37:40:20, 38:16:23)North
>> g.region n=38:16:23N w=119:57:40W s=37:40:20N e=119:02:55W  # set the region
>> v.in.region --overwrite output=MASK type=area  # create rectangle based on the region
>> v.to.rast --overwrite input=MASK output=MASK use=val  # convert to raster
>> r.mapcalc "n38_dem_1 = if(MASK,CA_N38W120)" # map calculator
>> r.mapcalc "n39_dem_1 = if(MASK,CA_N39W120)" # map calculator
>> r.patch input=n38_dem_1,n39_dem_1 output=Tuolumne_dem  # merging two dem data together
>> g.remove rast=n38_dem_1,n39_dem_1  # removing the useless dem data






