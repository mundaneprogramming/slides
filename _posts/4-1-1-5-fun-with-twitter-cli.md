
## Don't be a slave to social media

[I Nuked My Twitter Feed And You Should Too](http://www.buzzfeed.com/charliewarzel/i-nuked-my-twitter-feed-and-you-should-too) - Charlie Warzel

> There’s no reliable way to bulk unfollow, and besides, I wanted to savor the experience. The web client is the easiest way to go about this (on Twitter’s mobile every unfollow asks for confirmation) but it’s still a pain. 

--

## So much pain...

> The “unfollow” button isn’t very responsive to clicks and sometimes it took three or four tries to go through. This led to a lot of quick unfollow/refollow clicks, which would send a “Charlie Warzel is now following you on Twitter!” emails to friends, co-workers, family. 

--

> It’s a process that seems intentionally designed to be frustrating and it’s a pretty good deterrent for bulk unfollows. 

> Oh, and it took nearly three and a half hours. {% fragment %}

...so ...much {% fragment %}

...carpal tunnel {% fragment %}



--

## Repetitive work is good practice time

Even when it's as trivial as Twittery vanity projects.


--

## Combining tools

- [csvkit](https://csvkit.readthedocs.org/en/0.9.1/)
- [t (ruby) gem](https://github.com/sferik/t)


--

When an API and service are big, you can expect the authentication process to be somewhat of a bear. The [t gem's documentation](https://github.com/sferik/t/blob/master/README.md) has a nice walkthrough. 

But the bottom line is you can't just log in, programmatically, with your username and password.


--

When it's set up:

~~~sh
t whoami   # return information about authenticated user
~~~

    ID           14335332
    Since        Apr  8  2008 (7 years ago)
    Last update  @yrochat yup (33 minutes ago)
    Screen name  @dancow
    Name         Dan Nguyen      ؚ
    Tweets       23,508
    Favorites    6,333
    Listed       702
    Following    6,216
    Followers    8,118
    Bio          Programming, writing, photography, investigations. Computational Journalism Lecturer for @Stanford. Past: @Skift, @ProPublica, @sacbee_news.
    Location     Stanford, California
    URL          http://danwin.com

--

Just as there are many ways to download files outside of the web browser interface, an API lets a user/developer design their own interfaces:

~~~sh
t update "Hey world I'm at the command line" # send tweet
~~~

--

Make a directory to dump our work in:

~~~sh
mkdir -p /tmp/twits
cd /tmp/twits
~~~


--

Find out our most popular followers with [csvsort](https://csvkit.readthedocs.org/en/0.9.1/scripts/csvsort.html):

~~~sh
t followers --csv > followers.csv
csvsort -n followers.csv
csvsort -c 8 -r followers.csv 
~~~

--

Being able to filter is _vital_; humans can't be expected to interpret a massive wall of text like Neo. 


--

Here we use `csvkit` to filter the columns, then Unix-standard `head` to reduce the number of lines.

~~~sh
csvsort -c 8 -r followers.csv | csvcut -c 10,9,8
csvsort -c 8 -r followers.csv | csvcut -c 10,9,8 | head -n 10 
~~~


--

## Basically a bot

Test run

~~~sh
csvsort -c 8 -r followers.csv | csvcut -c 9 | head -n 3 |
while read -r line; do
  echo "I love you @$line"
done
~~~

Now tweet


~~~sh
csvsort -c 8 -r followers.csv | csvcut -c 9 | head -n 3 |
while read -r line; do
  t update "I love you, @$line"
done
~~~

--

## Unfollow en masse

~~~sh
t leaders --csv > leaders.csv
head -n 10 leaders.csv
t unfollow @user
~~~

--

## Be as granular/petty as you want

Follow the least popular of my non-followers:

~~~sh
csvsort -c 8 leaders.csv | head -n 100
# avoid angering stanford
csvsort -c 8 leaders.csv | head -n 100 | csvgrep -c 13 -i -m 'Stanford'
~~~
