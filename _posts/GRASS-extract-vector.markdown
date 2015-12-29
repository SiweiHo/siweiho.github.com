Here I give an example on how to extract the points within
certain region.
What I want to get all the points within the basin. I have
the basin vector and raster file, and the points in vector
format. Thus, this problem is to crop vector source map with
vector boundary map.

1. In order to include all the point, a buffer vector of the 
original vector is created,
>> v.buffer --overwrite input=LLaramie_shp output=LLaramie_buffer distance=0.005

2. Then cropping
However, since the source map are points. V.overlay command
does not work on it. So, I do this in edit model mannually.

3. output
>> v.out.ascii input=WRF_points@N42W107 output=/home/siwei/Desktop/test columns=seq,x,y
>> v.out.ascii input=WRF_points_2300_2500 output=/home/siwei/Dropbox/Research/Fokker-Planck/Data/WRF_pts_2300_2500.csv fs=, columns=x,y
>> v.out.ascii input=WRF_points_2500_2700 output=/home/siwei/Dropbox/Research/Fokker-Planck/Data/WRF_pts_2500_2700.csv fs=, columns=x,y
>> v.out.ascii input=WRF_points_2700_2900 output=/home/siwei/Dropbox/Research/Fokker-Planck/Data/WRF_pts_2700_2900.csv fs=, columns=x,y
>> v.out.ascii input=WRF_points_2900_3100 output=/home/siwei/Dropbox/Research/Fokker-Planck/Data/WRF_pts_2900_3100.csv fs=, columns=x,y
>> v.out.ascii input=WRF_points_3100_3300 output=/home/siwei/Dropbox/Research/Fokker-Planck/Data/WRF_pts_3100_3300.csv fs=, columns=x,y
>> v.out.ascii input=WRF_points_3300_up output=/home/siwei/Dropbox/Research/Fokker-Planck/Data/WRF_pts_3300_up.csv fs=, columns=x,y
