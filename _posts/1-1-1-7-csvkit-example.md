## Altering tabular data 

<img data-src="images/dead-spreadsheet.png">

--


## Excel is not that bad

Don't get me wrong, Excel (or any other modern spreadsheet) is the most ubiquitous, bang-for-your buck tool that you can learn.

But its designers can't account for all of the weird, sloppy ways that data gets transmitted {% fragment %}

--

And how do you describe or replicate those steps?

> Click in the first cell. Delete the contents. Type "title". Add a column before the first column ...

--

[How to avoid making an Excel mistake like Rogoff and Reinhart - Quartz (qz.com)](http://qz.com/75119/how-to-avoid-making-an-excel-mistake-like-rogoff-and-reinhart/) 

<img data-src="images/reinhartrogoffexcelqz.png">

--

## Make Reproducibility Work For You


Reproducibility, aka _replication_, is considered an _ideal_ in the pursuit of scientific research, but [is often too burdensome to be made a requirement](http://www.nature.com/news/first-results-from-psychology-s-largest-reproducibility-test-1.17433):

--

And this is key to making things __automatable_

...but you don't have to go full automation. Take it one step at a time. At the very least, you'll be able to stop on a mini-project and, when you can get back to it, start exactly where you were before.

--

Command line "programming"

~~~sh
# Convert Excel to CSV using in2csv, part of the awesome csvkit
in2csv ~/Downloads/Grateful_Dead_Track_Titles.xlsx |\
# Strip the first line of the file, an annoying document title
tail -n +2 |\
# Add a proper column header
sed -e '1s/^/title\
/' |\
# Add a line-number column to act as a quick-and-dirty primary key,
# because reconcile-csv needs it
csvcut -l > grateful_dead_track_titles.csv
~~~
