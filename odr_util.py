# odr_util.py - OpenOffice document reporting using xslt stylesheets
# CPython core

import sys
import os.path
import shutil
import zipfile
import libxml2
import libxslt

stylesheet_filename = "makecontentstylesheet.xslt"

docpath = "./" 
filename = docpath + "door_poc.odt"
datafile = docpath + "users.xml"

def list_odf_contents(filename):
    odffile = zipfile.ZipFile(filename)
    print "Date", "", "Size", "Compressed Size", "Name"
    print "----------------------------------------------------------------------------"
    for file in odffile.infolist():
            print file.date_time, file.file_size, file.compress_size, file.filename

def load_content_stream(filename, content_file="content.xml"):
    odffile = zipfile.ZipFile(filename)
    return odffile.read(content_file)

def save_content_ss(filename, ss):
    odffile = zipfile.ZipFile(filename, "a")
    odffile.writestr("content.xslt", ss)

def save_content_stream(filename, stream, content_file="content.xml"):
    newfile = zipfile.ZipFile(filename+".tmp", "w")
    odffile = zipfile.ZipFile(filename, "r")
    newfile.writestr(content_file, stream)
    for file in odffile.infolist():
        if content_file not in file.filename:
            newfile.writestr(file, odffile.read(file.filename))
    odffile.close()
    newfile.close()
    shutil.copy2(filename+".tmp", filename)

def generate_report_stylesheet(stream):
    xsltstream = open(stylesheet_filename)
    result = xsltproc_stream(xsltstream.read(), stream)
    xsltstream.close()
    return result

def xsltproc_file(xsltstream, filename):
    data = open(filename)
    result = xsltproc_stream(xsltstream, data.read())
    data.close()
    return result

def xsltproc_stream(xsltstream, stream):
    styledoc = libxml2.parseDoc(xsltstream)
    style = libxslt.parseStylesheetDoc(styledoc)
 
    xmldoc = libxml2.parseDoc(stream)
    resultxml = style.applyStylesheet(xmldoc, None)

    result = style.saveResultToString(resultxml)

    # Delete temporary objects
    style.freeStylesheet()
    xmldoc.freeDoc()
    resultxml.freeDoc()

    return result

def test_ss():
    #list_odf_contents(filename)
    print "Copying input file to door file..."
    ortfile = os.path.splitext(filename)[0]+".ort"
    shutil.copy2(filename, ortfile)

    print "Generating door content.xslt..."
    door_ss = generate_door_ss()
    print "Saving door file %s..." % ortfile
    save_content_ss(ortfile, door_ss)

    print "Copying input file to output file..."
    outfile = ".out".join(os.path.splitext(filename))
    shutil.copy2(filename, outfile)

    print "Generating output content.xml..."
    newcontent = generate_from_door(ortfile, datafile)
    save_content_stream(outfile, newcontent)

    print "New file saved as:", outfile

def generate_door_ss():
    input = load_content_stream(filename)
    output = generate_report_stylesheet(input)
    
    return output

def generate_from_door(ortfile, xmldata):
    door_ss = load_content_stream(ortfile, "content.xslt")
    newcontent = xsltproc_file(door_ss, xmldata)

    return newcontent

if __name__ == "__main__":
   test_ss()
   # print generate_ss()[1]
