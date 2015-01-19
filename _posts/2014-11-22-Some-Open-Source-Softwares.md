---
layout: post
title: Some Common Open Source Softwares
category: technique
tags: [Open Source; Gnuplot; Grass Gis; Linux]
---

**GNUPLOT**

With no doubt, MATLAB is one of the most powerful software for calculation
and plot. However, it is not free. So I have to find something to replace
it. GNUPLOT is the one that I used to plot. It is powerful and also the figure
is beautiful. More information you can visit its offical website. 

**GRASS GIS**

This is the one that I used to replace ArcGis. I have to admit that ArcGis
is powerful and user-friendly. The biggest problem is also relate with money.
I think GRASS can do as good as ArcGis except for map plotting. Another 
advantage of GRASS is freedom, I think. It can export data into many 
different format. Combining with Python, GRASS is a good choice for batch
processing.

**LATEX**

Latex is the traditional words processing program. It is a better choice
for alternative of OFFICE.

**VIM**

It is said that VIM is the most powerful editor in the world. I think this
maybe true. I am a newcomer for VIM.

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


.bashrc  
export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[00;36m\]\W\[\033[00;33m\]\$ "


---
