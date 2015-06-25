# Make Reproducibility Work For You

If you run out of small tools to build for yourself, then tackle side projects that are interesting, but not life/deadline-dependent.

--

Reproducibility, aka _replication_, is considered an _ideal_ in the pursuit of scientific research, but [is often too burdensome to be made a requirement](http://www.nature.com/news/first-results-from-psychology-s-largest-reproducibility-test-1.17433):


--


[How to avoid making an Excel mistake like Rogoff and Reinhart - Quartz (qz.com)](http://qz.com/75119/how-to-avoid-making-an-excel-mistake-like-rogoff-and-reinhart/) 

<img data-src="images/reinhartrogoffexcelqz.png">

--

In programming, a deterministic and predictable process is not only feasible, but is a natural consequence of how code works. It makes re-running complex tasks trivial (once you've run it _once_)


--

And this is key to making things __automatable_

...but you don't have to go full automation. Take it one step at a time. At the very least, you'll be able to stop on a mini-project and, when you can get back to it, start exactly where you were before.



--

## Excel is not that bad

Don't get me wrong, Excel (or any other modern spreadsheet) is the most ubiquitous, bang-for-your buck tool that you can learn.

But its designers can't account for all of the weird, sloppy ways that data gets transmitted {% fragment %}

--

## California education data sprawl

The CDE has a wealth of data, which -- often for understandable reason -- is scattered across different files and formats.

- Here's a [dozen years of vaccination rates in California kindergartens](http://www.cdph.ca.gov/programs/immunize/pages/immunizationlevels.aspx)
- Here's 15 years worth of [ACT, SAT, and AP test scores](http://www.cde.ca.gov/ds/sp/ai/) (i.e. 45 sheets in total)

--

<img data-src="images/calschoolsvaccpage.png">




--


Just _downloading_ these files is a pain. So start off with a limited goal: automate the _listing_ of the data URLs:

~~~py
import requests
from lxml import html
SITEURL = 'http://www.cdph.ca.gov/programs/immunize/pages/immunizationlevels.aspx'
resp = requests.get(SITEURL)
txt = resp.text
doc = html.fromstring(txt)
links = doc.cssselect("a")
for link in links:
  print(link.attrib['href'])
~~~


--

Doh! An error:

~~~
#
#
#middle_column
#pagefooter
/pages/accessibility.aspx
---------------------------------------------------------------------------
KeyError                                  Traceback (most recent call last)
<ipython-input-5-19710c9aeb70> in <module>()
      7 links = doc.cssselect("a")
      8 for link in links:
----> 9   print(link.attrib['href'])

lxml.etree.pyx in lxml.etree._Attrib.__getitem__ (src/lxml/lxml.etree.c:62258)()

KeyError: 'href'
~~~


--

Get a little better at working with HTML (in this case, learn the Xpath selector language):

~~~py
import requests
from lxml import html
SITEURL = 'http://www.cdph.ca.gov/programs/immunize/pages/immunizationlevels.aspx'
doc = html.fromstring(requests.get(SITEURL).text)
links = doc.xpath("//a/@href")
for link in links:
  print(link)
~~~


--

Too much junk:

~~~
/PROGRAMS/Pages/default.aspx',
 '/programs/immunize/Pages/Default.aspx',
 '/programs/immunize/Pages/ImmunizationLevels.aspx',
 '/programs/immunize/Documents/2014-15%20CA%20Child%20Care%20Immunization%20Assessment.pdf',
 '/programs/immunize/Documents/2014-15%20Child%20Care%20and%20School%20Fact%20Sheet.pdf',
 '/programs/immunize/Documents/2014-2015%20CA%20Child%20Care%20Data.pdf',
 '/programs/immunize/Documents/2014-2015%20CA%20Child%20Care%20Data.xlsx',
~~~

--

Learn how to filter (i.e. conditional statements) and how to better parse URLs:

~~~py
import requests
from lxml import html
from urllib.parse import urljoin
SITEURL = 'http://www.cdph.ca.gov/programs/immunize/pages/immunizationlevels.aspx'
doc = html.fromstring(requests.get(SITEURL).text)
for link in doc.xpath("//a/@href"):
  if 'xls' in link and 'Kinder' in link:
      url = urljoin(SITEURL, link)
      print(url)
~~~


--

Now you have links you can actually _click_ on and download manually. It's a start:

~~~py
http://www.cdph.ca.gov/programs/immunize/Documents/2014-15%20CA%20Kindergarten%20Data.xlsx
http://www.cdph.ca.gov/programs/immunize/Documents/2013-2014%20CA%20Kindergarten%20Data.xls
http://www.cdph.ca.gov/programs/immunize/Documents/2012-2013%20California%20Kindergarten%20Data.xls
http://www.cdph.ca.gov/programs/immunize/Documents/2011-2012%20CA%20Kindergarten%20Data.xls
~~~


--

That's one phase! You can save that script into a file and re-run it to your heart's content.

--

What's in these files?

For the [2012-2013 vaccination file](http://www.cdph.ca.gov/programs/immunize/Documents/2012-2013%20California%20Kindergarten%20Data.xls), we see that a plaintext translation of the spreadsheet won't be good enough. 


--

Someone has to hand-remove those leading blank lines, possibly from _every single page_:

<img data-src="images/cavacc1213-topper.png">


--

Oh, and whoever created this Excel workbook decided to use the __third__ sheet for the data, when most people expect it in the __first__. So that's yet another detail.


<img data-src="images/cavacc1213-bottom.png">


--

...And that's not even the worst of the inconsistencies between yearly datasets. The data columns have a different structure post-2012, reflecting a possible change in what they measure.

(the [high school test score data is even messier](http://www.cde.ca.gov/ds/sp/ai/))

--

But that's data in the real world, just an approximation of human efforts to observe and evaluate complex topics.

Sample scripts:

- [caschoolsimmunization_fetch.py](https://github.com/mundaneprogramming/mundaneprogramming.github.io/blob/master/code/caschoolsimmunization_fetch.py)

- [caschoolsimmunization_collate.py](https://github.com/mundaneprogramming/mundaneprogramming.github.io/blob/master/code/caschoolsimmunization_collate.py)




