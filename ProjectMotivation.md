# Introduction #

I spend a lot of time working with .Net-compatible reporting tools such as Crystal Reports and SSRS. A lot of this time is spent on the following tasks:

  * copying-and-pasting existing documents into the reporting framework
  * adding fields
  * making minor modifications (such as adding / removing sentences)
  * adding the same fields repeatedly (for example, addresses)
  * answering questions on why they can't do more ad-hoc reporting themselves

I don't believe I can solve all these problems, but with the right tools, it should be posible to let the users takes more responsibility and let the framework do more of the repetitive tasks. I started this project to see how far the tools and the framework could take us.

# N-tier #

Reporting is a presentation layer, just like a windows UI, or HTML. Reporting should not contain business logic, but should reformat data provided by a service layer into something easier to consume. It may be an office document, it may be a PDF, or it may take another form.

In order to interface with as wide a range of service layers as possible, DOOR will accept XML (preferably XSD-specified) as input, and use XSLT to generate ODF as output, and will rely on existing convertors from the ODF standard to generate PDF, OOXML or other formats.