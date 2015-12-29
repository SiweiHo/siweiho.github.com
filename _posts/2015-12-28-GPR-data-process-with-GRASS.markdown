---
layout: post
title: GPR data process with GRASS
category: technique
tags: [GRASS; Linux]
---

I have some GPR (Ground penetrating radar) data (.rad, .rd3, .cor) and here I just focus on .cor
file since this file contains the location information of GPR route (trace).
My aims are:
1. Ddisplay GPR route in Google Earth (GE)
2. Extercting the elevation informtion along these route from 
NED (National Elevation Data) via GRASS.

Here are what I have done.

**1. Converting .cor file to .csv file**  
I finished this via Fortran program. The information I extrated are 
latitude and longitude.

**2. Setting coordinate system**  
Only with corret coordinate system, we can properly import routes into 
GE.  
2.1 Open a new GRASS session, and create a new location, for example
google_earth.  
2.2 Set coordinate system based on EPSG code. Select EPSG code 4326 for
WGS84: this is the unprojected latitude and longitude.

**3. Import .csv file to GRASS**  
We already have the .csv file in the step 1. We have two choices here.
Import as points or as lines.  
Import as points:  
`v.in.ascii --overwrite input=DAT_0015_A1.csv output=test_pt1 fs=, 
skip=0 columns=lon double precision, lat double precision, elev double precision cat=0`  
Import as lines:  
`v.in.lines --overwrite input=DAT_0001_0015_A1.csv output=Feb5_GPR_route fs=,`  
The advantage of lines is that it is easy to manage since we have
only one element in the .KML file. The advantage of points is that
it is easy to extract DEM information from NED raster data since
we can get elevation via updating attribute table.

**4. Export .KML file for GE**  
We already have the vectors of route, one for points and one for lines.
I exported lines file to .KML file.  
`v.out.ogr input=Feb5_GPR_route@PERMANENT type=line dsn=Feb5_GPR_route.kml format=KML`  
The we can open the .KML file through GE.  

**5. Extract elevation from NED data**  
I make this operation in another session, that is NED projection system.
The consistence of coordinate system is very important since it would
induce serious problem. I give all commands since it is easy to understand:  
`v.in.ascii --overwrite input=DAT_0015_A1.csv output=test_pt1 fs=,
  skip=0 columns=lon double precision, lat double precision, elev double precision cat=0`  
`v.db.addcol map=test_pt@N42W107 columns=dem double precision`  
`v.what.rast vector=test_pt raster=N40E109 column=dem`  
`v.out.ascii input=test_pt@N42W107 output=test.csv fs=, columns=elev,dem`  

Now, we have the NED elevation in our new .csv file.

---

