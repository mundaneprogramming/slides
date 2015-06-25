## Altering tabular data 

Of course you can edit the data in a spreadsheet application:

<img data-src="images/dead-spreadsheet.png">

--

But how do you describe or replicate those steps?

> Click in the first cell. Delete the contents. Type "title". Add a column before the first column ...

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
