## Aim small

The hardest thing for novice programmers is to not _just_ troubleshooting cryptic error messages...

But to know what the _correct_ result is supposed to have been, rather than just the "whew, nothing broke!"-type errors...which can be just as deadly.


--

## Start with the toys

On Linux or OS X, try editing your `~/.bash_profie` or `~/.bashrc` file, respectively, and add useful functions:

~~~sh
# Put a monster in the prompt
export PS1="\u ༼ つ◕_◕༽つ\w $ "
# change the background color of the Terminal
change_bg(){
  osascript -e "tell application \"Terminal\" to set background color of window 1 to $1"
}
go_py(){
  change_bg '{42000, 50000, 40000, 50000}'
  export PS1="\u ～～～(╹◡╹) \w $ "
}
~~~


--

These may seem like trivial kinds of scripting, but it is _essential_ practice in getting more cognitively comfortable with the often unforgiving syntax of programming languages.

--

As you get more comfortable, look to creating more useful functions that are still low-risk, low-yield. This one turns a movie file into a GIF:

~~~sh
quickiegiffie()
{
  # example:  gifify somemovie.mov someimage.gif
  # uses gifify to convert movie file into GIF https://github.com/jclem/gifify/
  # at 20fps at 2x speed, resize to 800px wide
  gifify -s 2 -r 20 $1 -o $2 --resize 800:-1

}
~~~


--

No task is too small to practice on.

