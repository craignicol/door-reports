# odrutili.py - OpenOffice document reporting using xslt stylesheets
# IronPython core

import clr
clr.AddReference("ICSharpCode.SharpZipLib")
from ICSharpCode.SharpZipLib import Zip

clr.AddReference("System.Xml")
from System.Xml.Xsl import XslCompiledTransform
from System.Xml.XPath import XPathDocument

from System.IO import MemoryStream

import sys
import System

stylesheet_filename = "makecontentstylesheet.xslt"

docpath = "./" # "C:\\Documents and Settings\\Craig.Nicol\\My Documents\\"
filename = docpath + "test_fields_template.ott"
xmldatafile = docpath + "users.xml"

def list_odf_contents(filename):
    odffile = Zip.ZipFile(filename)
    print "Date", "", "Size", "Compressed Size", "Name"
    print "----------------------------------------------------------------------------"
    for file in odffile:
            print file.DateTime, file.Size, file.CompressedSize, file.Name

def load_content_stream(filename):
    odffile = Zip.ZipFile(filename)
    contentZipEntry = odffile.GetEntry("content.xml")
    return odffile.GetInputStream(contentZipEntry)

def ascii_from_stream(stream, bufferSize=10000):	
    contentByteArray = System.Array.CreateInstance(System.Byte, bufferSize)
    
    raw_content = ""
    bytesRead = bufferSize
    offset = 0

    while bytesRead == bufferSize:
            bytesRead = stream.Read(contentByteArray, 0, bufferSize)
            raw_content += System.Text.ASCIIEncoding().GetString(contentByteArray, 0, bytesRead)
            offset += bytesRead
            
    return raw_content

def generate_report_stylesheet(stream, xsltfile):
    xsl = XslCompiledTransform()
    xsl.Load(xsltfile)
    
    xpd = XPathDocument(stream)
    
    outstream = MemoryStream(10000)
    
    xsl.Transform(xpd, None, outstream)
    
    return outstream
	
def test_ss():
    list_odf_contents(filename)
    generate_ss()

def generate_ss(odffile=filename, xsltfile=stylesheet_filename):
    input = load_content_stream(odffile)
    output = generate_report_stylesheet(input, xsltfile)
    #reset stream
    output.Seek(0, System.IO.SeekOrigin.Begin)
    
    return(ascii_from_stream(input), ascii_from_stream(output), input, output)

def generate_doc(xsltstream, odffile=filename, xmldata=xmldatafile):
    input = FileStream(xmldata)

if __name__ == "__main__":
    print generate_ss()[1]
