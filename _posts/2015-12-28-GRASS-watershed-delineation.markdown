---
layout: post
title: GRASS watershed delineation
category: technique
tags: [GRASS; watershed; delineation]
---

I have the DEM data in geographic (lon-lat) coordinate system, and also one specific
outlet of a basin.
What I want is to delineate the accumulation area of this basin via GRASS

Here are what I have done.

**1. Cropping the DEM to a small area.**
This is used to reduce the computation time of all below steps.
`>> g.region n=41:25:00N w=106:20:00W s=41:09:00N e=106:00:00W`  # set the region
`>> v.in.region --overwrite output=MASK type=area`  # create rectangle based on the region
`>> v.to.rast --overwrite input=MASK@N42W107 output=MASK use=val`  # convert to raster
`>> r.mapcalc "LLaramie_dem = if(MASK,n42w107_dem)" `# map calculator

**2. Converting the geographic coordinate system to the projected coordinate systems (UTM in case)**
`>> g.mapset mapset=LLaramie location=smooth_UTM`  # change directory to UTM directory
`>> v.proj input=MASK location=NED_DEM mapset=N42W107`  # vector map should be first
`>> g.region vect=MASK`  # setting default region
`>> r.proj --overwrite input=LLramie_dem location=NED_DEM mapset=N42W107 output=LLaramie_dem method=cubic resolution=30` # raster data
`>> v.proj input=usgs_site location=NED_DEM mapset=N42W107`  # projecting outlet

**3. Running r.watershed command**
`>> g.region -p rast=LLaramie_dem@LLaramie`  # setting the region for calculation
`>> r.watershed -f elevation=LLaramie_dem@LLaramie accumulation=accum drainage=fdir basin=catch stream=stream threshold=5000`
`>> r.water.outlet drainage=fdir@LLaramie basin=LLaramie_basin easting=413381.332614 northing=4572021.474385`  # watershed, the 
 coordinate of outlet should be checked and got from the stream result.
`>> r.to.vect --overwrite input=LLaramie_basin@LLaramie output=LLaramie_shp feature=area`  # getting the basin boundary vector 

**4. Cropping all the data within basin**
`>> r.mapcalc "basin_dem = if(LLaramie_basin,LLaramie_dem)" ` # for DEM
`>> r.mapcalc basin_stream = if(LLaramie_basin,stream)`  # for stream
`>> r.mapcalc basin_accum = if(LLaramie_basin,accum)`  # for accumulation

**5. Outputting the ASCII text file**
`>> r.out.ascii input=basin_dem@LLaramie output=./LLaramie_dem_grass null=-9999`

**6. Projecting the DEM and boundary of basin into geographic coordinate system**
`>> g.mapset mapset=N42W107 location=NED_DEM`  # change directory to geographic system
`>> r.proj --overwrite input=basin_dem location=smooth_UTM mapset=LLaramie output=LLramie_dem method=cubic`
`>> v.proj --overwrite input=LLaramie_shp location=smooth_UTM mapset=LLaramie output=LLaramie_shp`



