---
layout: post
title: Common Notes
category: technique
tags: [Open Source; Gnuplot; Grass Gis; Linux]
---

**Links**

<li> <a href="https://grass.osgeo.org/" target="_blank">GRASS GIS</a> </li>
<li> <a href="http://www.qgis.org/en/site/" target="_blank">QGIS</a> </li>
<li> <a href="https://www.latex-project.org/" target="_blank">LaTex</a> </li>
<li> <a href="http://pandoc.org/" target="_blank">Pandoc</a> </li>
<li> <a href="https://www.lyx.org/" target="_blank">LyX</a> </li>

**Installing VTK**
`>> sudo apt-get install cmake`  
`>> sudo apt-get install cmake-curses-gui`  
then, download VTK and VTKDATA  
`>> sudo apt-get install libpng-dev libjpeg-dev libxxf86vm1 libxxf86vm-dev libxi-dev libxrandr-dev`  
`>> sudo apt-get install mesa-common-dev`  
`>> sudo apt-get install mesa-utils-extra libgl1-mesa-dev libglapi-mesa`  
`>> sudo apt-get install libxt-dev`  
`>> tar zxf VTK`  
`>> tar zxf VTKData`  
`>> cd VTK`  
`>> ccmake`  
`>> make`  
`>> sudo make install`  

**What I do After Installing Linux**

Soft Center  
*>> Dropbox*  
*>> Terminator*  
*>> Grass*  

Command Line  
`>> sudo apt-get install vim`  
`>> sudo apt-get install build-essential`  
`>> sudo apt-get install gfortran`  
`>> sudo apt-get install gnuplot-x11`   
`>> sudo apt-get install texlive-full`  

For QGIS  
`>> sudo apt-get install python-software-properties`   
`>> sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable`  
`>> sudo apt-get update`  
`>> sudo apt-get install qgis python-qgis qgis-plugin-grass`  

For Python
`>> sudo apt-get install python-matplotlib`  
`>> sudo apt-get install python-tk`  
`>> sudo apt-get install python-scipy`  
`>> sudo apt-get install python-mpltoolkits.basemap`  

 /etc/vim/vimrc  
`set number` (Display line number)   
`set nowrap` (Stop automatic wrap)  
`set expandtab` (For automatic indentation)  
`set shiftwidth=2` (For automatic indentation)  
`set autoindent` (For automatic indentation)   
`set smartindent` (For automatic indentation)  
`set fileencodings=utf-8,gb2312,gbk,gb18030` (For Chinese messy code)  
`set termencoding=utf-8` (For Chinese messy code)    
`set encoding=prc` (For Chinese messy code)    


.bashrc (at home directory)
`export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[00;36m\]\W\[\033[00;33m\]\$ "`


---
