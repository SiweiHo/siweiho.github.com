---
layout: post
title: First
category: technique
tags: [test; highlight; picture]
---

**1. Install**
1.1 Download program from <ftp://ftp.unidata.ucar.edu/pub/netcdf/>
The programs that I have downloaded are: 
* hdf5-1.8.9.tar.gz
* zlib-1.2.7.tar.gz
* netcdf-4.3.2.tar.gz
* netcdf-fortran-4.4.0.tar.gz

1.2 Build and install zlib
'>> tar -zxvf zlib-1.2.7.tar.gz'
'>> cd zlib-1.2.7'
'>> ./configure --prefix=/usr/local'
'>> sudo make check install'

1.3 Build and install hdf5
'>> tar -zxvf hdf5-1.8.9.tar.gz'
'>> cd hdf5-1.8.9'
'>> CFLAGS=-O0 ./configure --with-zlib=/usr/local --prefix=/usr/local'
(The CFLAGS=-O0 is only required if you get error without it) 
'>>  sudo make check install'

1.4 Build and install netcdf
'>> tar -zxvf netcdf-4.3.2.tar.gz'
'>> cd netcdf-4.3.2'
'>> CPPFLAGS=-I/usr/local/include LDFLAGS=-L/usr/local/lib 
./configure --prefix=/usr/local'
'>> sudo make check install'

1.5 Set environmental variables
'ENV_VARIABLE=/usr/local'
'export LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}'

1.6 Build and install netcdf-fortran
'>> tar -zxvf netcdf-fortran-4.4.0.tar.gz'
'>> cd netcdf-fortran-4.4.0'
'>> CPPFLAGS=-I/usr/local/include LDFLAGS=-L/usr/local/lib 
./configure --prefix=/usr/local'
'>> make check'
'>> sudo make install'

With above steps, I'm sure that you can use netcdf via fortran.
Two screenshots,
![Screenshot for netCDF](/images/netcdf.png)
![Screenshot for netCDF-Fortran](/images/netcdf-fortran.png)



**2. Call NetCDF function**
If everything is okay, then you can call netcdf function in the fortran 
program. Actually, I think this is easier than above installation processes.
A very generally way is copied from NetCDF-Fortran user guide 
<https://www.unidata.ucar.edu/software/netcdf/docs/netcdf-f90.html>,

* NF90_CREATE ! create netCDF dataset: enter define mode ...
* NF90_DEF_DIM ! define dimensions: from name and length ...
* NF90_DEF_VAR ! define variables: from name, type, dims ...
* NF90_PUT_ATT ! assign attribute values ...
* NF90_ENDDEF ! end definitions: leave define mode ...
* NF90_PUT_VAR ! provide values for variable ...
* NF90_CLOSE ! close: save new netCDF dataset

**3. View**
I think view is important since we can check our results conveniently 
if we can view them conveniently. Obviously, there are many programs 
are available in the internet. However, I think HDFView 
<http://www.hdfgroup.org/products/java/hdfview/>
is the most friendly and useful for new user. I have tried many times
before I successfully installing it. Here are my experience,

* apt-get install hdfview (Fail)
* HDF-Java 2.11 Pre-Built Binary Distribution (Fail)
* HDF-Java 2.11 Source Code (Success)

The details of the third method is given by web 
<http://www.hdfgroup.org/products/java/release/downloadsrc.html>.
However, I have to mention that you should install cmake and jave 
firstly before using this method.

'>> sudo apt-get install cmake'
'>> sudo apt-get install default-jre'
'>> sudo apt-get install default-jdk'
'>> sudo apt-get install openjdk-7-jre'

After build successfully, you should go to *./hdf-java/build/*,
and then type: 
'>> sudo make install'

After successfully install, you can start it in command 
line with: *hdfview.sh*

---

