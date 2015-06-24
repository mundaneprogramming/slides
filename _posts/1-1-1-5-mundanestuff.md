## Mundane programming can happen anywhere

Just testing out the highlighting...

~~~py
import requests
from lxml import html
txt = requests.get("http://www.nytimes.com").text
doc = html.fromstring(txt)
print(len(doc.cssselect("h2.story-heading")), 'headlines on nytimes' )
~~~
