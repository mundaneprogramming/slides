# very dangerous...
jekyll build
gh_tmpdir="/tmp/jekyllreveal/$(date -I)"
echo Saving to $gh_tmpdir
## now move site over
mv _site/* $gh_tmpdir
git checkout -B gh-pages
rm -r *
mv $gh_tmpdir/* .
git add .
git commit -am "Hello update at $(date -I)"
git push origin gh-pages --force
git checkout master
echo "YOLO"


# http://blog.nitrous.io/2013/08/30/using-jekyll-plugins-on-github-pages.html
# system "mv _site/* #{tmp}"
# system "git checkout -B gh-pages"
# system "rm -rf *"
# system "mv #{tmp}/* ."
# message = "Site updated at #{Time.now.utc}"
# system "git add ."
# system "git commit -am #{message.shellescape}"
# system "git push origin gh-pages --force"
# system "git checkout master"
# system "echo yolo"
