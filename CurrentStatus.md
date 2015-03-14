# Introduction #

This is just a proof of concept to see what is possible with XSLT and ODF to replace common functions of reporting tools such as generating letters and charts from a database or a web service. It currently only demonstrates part of the first, but by creating XSLT stylesheets to cover common functionality, we can build a library of XML snippets that can be used to inform the design of a developer API and a user GUI to create, modify, integrate and test reports within a software project.

# Disclaimer #

The proof of concept currently uses an XSLT stylesheet to generate a door-compatible file (with the placeholder filename of or? to compliment the od? convention of ODF). Whilst this is useful for automatically generating test documents that can be hand-edited, I do not anticipate this being the primary means of developing door-compatible files. In particular, this method is prone to producing invalid ODF output files that contain nested `text:p` elements.