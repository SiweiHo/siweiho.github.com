!***************************************************************************

! This program is used to obtain soil texture data according to the data of Yongjiu Dai,
! The soil texture classify system is USDA
! Written by He Siwei, 08/25/2013
! If you you have any question about this program, please let me known, hesiweide@163.com  
! compile:
! gfortran -o soil_triangle soil_triangle.f90 /usr/local/lib/libnetcdf.a -I/usr/local/include

! subroutine what_tex() and inpoly() is downloaded from web. The details can be found 
! in the subroutine.
!***************************************************************************

program main
  
  use netcdf
  
  implicit none 
   
   !---------Variables declaration-----------------------------------------------------------------------
   ! input files information
   character*200, parameter :: file_clay = "./CL.nc"
   character*200, parameter :: file_sand = "./SA.nc"   
   integer*4, parameter :: depth=1, num_lon=7560, num_lat=4320 
   real*4, parameter :: MISSVALUE = -9999
   
   ! function
   character :: what_texture*42
   
  ! **  Loop variables.  **
  integer :: i, j, dep
  character*200 :: IFNAME, texture

  ! **  Variables needed NetCDF functions.  **
  integer*4, dimension(3) :: start
  integer :: count(3)=(/num_lon, num_lat, 1/)
  integer*4 :: ncid, stat

  ! **  Working array.  **
  real*4, dimension(num_lon, num_lat) :: ivar_clay
  real*4, dimension(num_lon, num_lat) :: ivar_sand
  integer*4, dimension(num_lon, num_lat) :: soil_class
  integer :: error=0
  
  
  !///////////////////////////////////////// executing ///////////////////////////////////////
  
  ! determining the soil texture based on the clay and sand content level
   do dep = 1, depth
   
	write(*,*) "The depth is ", dep
	start(1)=1
	start(2)=1
	start(3)=dep
	! read clay content 
	stat = nf90_open (file_clay, nf90_nowrite, ncid)
	write(*,*) STAT, file_clay
	call check (stat)
	stat = nf90_get_var (ncid, 4, ivar_clay, start, count)
	call check (stat)
	stat = nf90_close (ncid)
	call check (stat)
	  
	! read sand content 
	stat = nf90_open (file_sand, nf90_nowrite, ncid)
	write(*,*) STAT, file_sand
	call check (stat)
	stat = nf90_get_var (ncid, 4, ivar_sand, start, count)
	call check (stat)
	stat = nf90_close (ncid)
	call check (stat)
   
	do i=1, num_lon
		do j=1, num_lat		

			texture = what_texture (ivar_sand(i,j), ivar_clay(i,j))
			select case (texture)
				case('/silt loam')
					soil_class(i,j)=1
				case('/sand')
					soil_class(i,j)=2
				case('/silty clay loam')
					soil_class(i,j)=3
				case('/loam')
					soil_class(i,j)=4
				case('/clay loam')
					soil_class(i,j)=5
				case('/sandy loam')
					soil_class(i,j)=6
				case('/silty clay')
					soil_class(i,j)=7
				case('/sandy clay loam')
					soil_class(i,j)=8
				case('/loamy sand')
					soil_class(i,j)=9
				case('/clay')
					soil_class(i,j)=10
				case('/silt')
					soil_class(i,j)=11
				case('/sandy clay')
					soil_class(i,j)=12
				case('/unknown texture')
					soil_class(i,j)=MISSVALUE
			end select
		end do  ! latitude loop
	end do ! logitude loop
	
	! output file name
	write(IFNAME, '(A13, I1, A4)') "soil_texture_", dep, ".txt"
	write(*,*) IFNAME
	open(22, file = IFNAME, form = 'formatted')
	write(22,*) "ncols ", num_lon
	write(22,*) "nrows ", num_lat
	write(22,*) "xllcorner ", 73.004166
	write(22,*) "yllcorner ", 18.004168
	write(22,*) "cellsize ", 0.008333333
	write(22,*) "NODATA_value ", -9999
	
	
	! writting variables to the point files, grid by grid 
	do j = num_lat,1, -1 
		do i= 1, num_lon			
			write(22, 33, advance='no') soil_class(i,j)
		end do
		33 FORMAT(I7)
		write(22,*) ' '
	end do

	close(22)
	
  end do   ! depth loop	

  contains

  ! --  Subordinate subroutines and functions.  ----------------------------------------------------

  subroutine check (status)

    integer, intent(in) :: status

    if (status /= nf90_noerr) then
      write (*, *) trim (nf90_strerror (status))
      stop "Stopped"
    end if

  end subroutine check

		
end program main


 !--------------------------------------------------------------------------
 !                            INPOLY
 !   Function to tell if a point is inside a polygon or not.
 !--------------------------------------------------------------------------
 !   Copyright (c) 1995-1996 Galacticomm, Inc.  Freeware source code.
 !
 !   Please feel free to use this source code for any purpose, commercial
 !   or otherwise, as long as you don't restrict anyone else's use of
 !   this source code.  Please give credit where credit is due.
 !
 !   Point-in-polygon algorithm, created especially for World-Wide Web
 !   servers to process image maps with mouse-clickable regions.
 !
 !   Home for this file:  http://www.gcomm.com/develop/inpoly.c
 !
 !                                       6/19/95 - Bob Stein & Craig Yap
 !                                       stein@gcomm.com
 !                                       craig@cse.fau.edu
 !--------------------------------------------------------------------------
 !   Modified by:
 !   Aris Gerakis, apr. 1998: 1.  translated to Fortran
 !                            2.  made it work with real coordinates
 !                            3.  now resolves the case where point falls
 !                                on polygon border.
 !   Aris Gerakis, nov. 1998: Fixed error caused by hardware arithmetic
 !   Aris Gerakis, july 1999: Now all borderline cases are valid
 !--------------------------------------------------------------------------
 !   Glossary:
 !   function inpoly: true=inside, false=outside (is target point inside
 !                    a 2D polygon?)
 !   poly(*,2):  polygon points, [0]=x, [1]=y
 !   npoints: number of points in polygon
 !   xt: x (horizontal) of target point
 !   yt: y (vertical) of target point
 !--------------------------------------------------------------------------
 
logical function inpoly (poly, npoints, xt, yt)

implicit none

! Declare arguments:

integer :: npoints
real    :: poly(7, 2), xt, yt

! Declare local variables:

real    :: xnew, ynew, xold, yold, x1, y1, x2, y2
integer :: i
logical :: inside, on_border

inside = .false.
on_border = .false.

if (npoints < 3)  then
  inpoly = .false.
  return
end if

xold = poly(npoints,1)
yold = poly(npoints,2)

do i = 1 , npoints
  xnew = poly(i,1)
  ynew = poly(i,2)

  if (xnew > xold)  then
    x1 = xold
    x2 = xnew
    y1 = yold
    y2 = ynew
  else
    x1 = xnew
    x2 = xold
    y1 = ynew
    y2 = yold
  end if

  ! The outer IF is the 'straddle' test and the 'vertical border' test.
  ! The inner IF is the 'non-vertical border' test and the 'north' test.  

  ! The first statement checks whether a north pointing vector crosses  
  ! (stradles) the straight segment.  There are two possibilities, depe-
  ! nding on whether xnew < xold or xnew > xold.  The '<' is because edge 
  ! must be "open" at left, which is necessary to keep correct count when 
  ! vector 'licks' a vertix of a polygon.  

  if ((xnew < xt .and. xt <= xold) .or. (.not. xnew < xt .and. &
     .not. xt <= xold)) then
    ! The test point lies on a non-vertical border:
    if ((yt-y1)*(x2-x1) == (y2-y1)*(xt-x1)) then
      on_border = .true. 
    ! Check if segment is north of test point.  If yes, reverse the 
    ! value of INSIDE.  The +0.001 was necessary to avoid errors due   
    ! arithmetic (e.g., when clay = 98.87 and sand = 1.13):   
    elseif ((yt-y1)*(x2-x1) < (y2-y1)*(xt-x1) + 0.001) then
      inside = .not.inside ! cross a segment
    endif
  ! This is the rare case when test point falls on vertical border or  
  ! left edge of non-vertical border. The left x-coordinate must be  
  ! common.  The slope requirement must be met, but also point must be
  ! between the lower and upper y-coordinate of border segment.  There 
  ! are two possibilities,  depending on whether ynew < yold or ynew > 
  ! yold:
  elseif ((xnew == xt .or. xold == xt) .and. (yt-y1)*(x2-x1) == &
    (y2-y1)*(xt-x1) .and. ((ynew <= yt .and. yt <= yold) .or. &
    (.not. ynew < yt .and. .not. yt < yold))) then
    on_border = .true. 
  endif

  xold = xnew
  yold = ynew

enddo

! If test point is not on a border, the function result is the last state 
! of INSIDE variable.  Otherwise, INSIDE doesn't matter.  The point is
! inside the polygon if it falls on any of its borders:

if (.not. on_border) then
   inpoly = inside
else
   inpoly = .true.
endif

return

end function inpoly


!* +-----------------------------------------------------------------------
!* | WHAT TEXTURE?
!* | Function to classify a soil in the triangle based on sand and clay %
!* +-----------------------------------------------------------------------
!* | Created by: aris gerakis, apr. 98
!* | Modified by: aris gerakis, june 99.  Now check all polygons instead of
!* | stopping when a right solution is found.  This to cover all borderline 
!* | cases.
!* +-----------------------------------------------------------------------
character*42 function what_texture (sand, clay)

implicit none

! Declare arguments:

real, intent(in) :: clay, sand

! Declare local variables:

logical   :: inpoly
real      :: silty_loam(7,2), sandy(7,2), silty_clay_loam(7,2), loam(7,2), &
             clay_loam(7,2), sandy_loam(7,2), silty_clay(7,2), &
             sandy_clay_loam(7,2), loamy_sand(7,2), clayey(7,2), silt(7,2), &
             sandy_clay(7,2)
character :: texture*42

!Initalize polygon coordinates:
! First write all x's, pad with 0s if less than 7 vertices, then
! write all y's, pad with 0s if less than 7 vertices:

data silty_loam/0, 0, 23, 50, 20, 8, 0, 12, 27, 27, 0, 0, 12, 0/
data sandy/85, 90, 100, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0/
data silty_clay_loam/0, 0, 20, 20, 0, 0, 0, 27, 40, 40, 27, 0, 0, 0/
data loam/43, 23, 45, 52, 52, 0, 0, 7, 27, 27, 20, 7, 0, 0/
data clay_loam/20, 20, 45, 45, 0, 0, 0, 27, 40, 40, 27, 0, 0, 0/
data sandy_loam/50, 43, 52, 52, 80, 85, 70, 0, 7, 7, 20, 20, 15, 0/
data silty_clay/0, 0, 20, 0, 0, 0, 0, 40, 60, 40, 0, 0, 0, 0/
data sandy_clay_loam/52, 45, 45, 65, 80, 0, 0, 20, 27, 35, 35, 20, 0, 0/
data loamy_sand/70, 85, 90, 85, 0, 0, 0, 0, 15, 10, 0, 0, 0, 0/
data clayey/20, 0, 0, 45, 45, 0, 0, 40, 60, 100, 55, 40, 0, 0/
data silt/0, 0, 8, 20, 0, 0, 0, 0, 12, 12, 0, 0, 0, 0/
data sandy_clay/45, 45, 65, 0, 0, 0, 0, 35, 55, 35, 0, 0, 0, 0/

! Find polygon(s) where the point is.

texture = ' '

if (sand .ge. 0.0 .and. clay .ge. 0.0) then
   if (inpoly(silty_loam, 6, sand, clay)) then
      texture = trim(texture)//'/silt loam'
   endif
   if (inpoly(sandy, 3, sand, clay)) then
      texture = trim(texture)//'/sand'
   endif
   if (inpoly(silty_clay_loam, 4, sand, clay)) then
      texture = trim(texture)//'/silty clay loam'
   endif
   if (inpoly(loam, 5, sand, clay)) then
      texture = trim(texture)//'/loam'
   endif
   if (inpoly(clay_loam, 4, sand, clay)) then
      texture = trim(texture)//'/clay loam'
   endif
   if (inpoly(sandy_loam, 7, sand, clay)) then
      texture = trim(texture)//'/sandy loam'
   endif
   if (inpoly(silty_clay, 3, sand, clay)) then
      texture = trim(texture)//'/silty clay'
   endif
   if (inpoly(sandy_clay_loam, 5, sand, clay)) then
      texture = trim(texture)//'/sandy clay loam'
   endif
   if (inpoly(loamy_sand, 4, sand, clay)) then
      texture = trim(texture)//'/loamy sand'
   endif
   if (inpoly(clayey, 5, sand, clay)) then
      texture = trim(texture)//'/clay'
   endif
   if (inpoly(silt, 4, sand, clay)) then
      texture = trim(texture)//'/silt'
   endif
   if (inpoly(sandy_clay, 3, sand, clay)) then
      texture = trim(texture)//'/sandy clay'
   endif
endif

if (texture == ' ') then
   texture = '/unknown texture'
   !write (unit = 6, fmt = 1000) sand, clay
   !1000 format (/, 1x, 'Texture not found for ', f15.1, ' sand and ', f15.1, ' clay')
endif

what_texture = texture

return
end function what_texture

  