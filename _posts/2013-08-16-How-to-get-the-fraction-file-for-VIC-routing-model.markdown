---
layout: post
title: how to get the fraction file for VIC routing model
category: technique
tags: [ArcGis; routing model; VIC; fraction file]
---

At first, you should have a boundary file (*hhup.shp* in this example) and a gridding 
file (*Raster_hhup_grid.shp* in this example). In the attribute table of gridding file, 
perimeter and area field should be contained.

**NOTICE:** 
1. The grid file should be converted from a raster file, but not from fishnet or other file.
2. the coordinate system should be Projection Coordinate System, so you can get the 
area and perimeter of every gird.

![This is picture1](/images/20130816_pic1.jpg)

**Step 1, erasing**

In this step, the *erase* command was used, and the corresponding inputs and output 
as following figure.

![This is picture2](/images/20130816_pic2.jpg)

**Step 2 recalculating**

Adding a new field in the attribute table of *hhup_grid_Erase* and calculating the area 
again.

![This is picture3](/images/20130816_pic3.jpg)

**Step 3, joining**

In this step, the *spatial join* command was used. Choosing *Join operation* 
as **JOIN_ONE_TO_ONE**, and *match option* as **CONTAINS**.

![This is picture4](/images/20130816_pic4.jpg)

Then, in the attribute table of output feature class, that is *hhup_grid_SpatialJoin4*, 
field *area_12* is the area that was not included in the river boundary for every grid.

![This is picture5](/images/20130816_pic5.jpg)

**Step 4, turning to raster**

Using the command *Feature to raster*, and choosing *Field* as **area_12**, **area**, 
respectively. The output raster was named as *hhup_frac* and *hhup_frac_bas* successively.

![This is picture6](/images/20130816_pic6.jpg)

Following are the results.

![This is picture7](/images/20130816_pic7.jpg)

**Step 5, raster calculating**

By *Spatial Analyst/Raster Calculator*, the area percentage of every grid can be obtained.

![This is picture8](/images/20130816_pic8.jpg)

**Step 6, outputting**

![This is picture9](/images/20130816_pic9.jpg)

At this, you can get the fraction file that routing model of VIC asked for.


---
