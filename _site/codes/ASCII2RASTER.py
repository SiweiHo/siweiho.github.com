# download from http://forums.arcgis.com/threads/42270-Ascii-to-Raster-Conversion-help
# revised by Siwei He (hesiweide@163.com), Oct 31, 2013

import glob,os
import arcgisscripting

#path = r'E:\data\albedo'
path = os.path.abspath(os.path.join(os.getcwd()))
gp=arcgisscripting.create()
gp.workspace=path
# arcpy.env.workspace = path 
os.chdir(path)

try:

    # Make a list of asc files in the workspace
    listAsc = glob.glob('*.txt')
        
    for currentFile in listAsc:

        # Find the current file name and path
        name = currentFile[:-4]
        textFilePath = path + '/' + currentFile       

        # Create a raster from the current file
        # arcpy.ASCIIToRaster_conversion(textFilePath,name + '.tif','FLOAT')
        gp.ASCIIToRaster_conversion(textFilePath,name + '.tif','FLOAT')
        # print(arcpy.GetMessages() + "\n")
        print(gp.GetMessages() + "\n")  
    
        
# Get error messages
except:
#    arcpy.GetMessages(2)
    print gp.GetMessages()
