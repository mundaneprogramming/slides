# very dangerous...
#
gh_tmpdir="/tmp/jekyllreveal/$(date -I)"

echo "WARNING: This script essentially wipes clean gh-pages and does a git
   force push to update the branch.

   - The temp directory $gh_tmpdir has been created
   and _site/* will be moved into it during the
   git checkout -B gh-pages and rm -r *

   BUT...sleeping for 5 seconds just in case you get the heebie jeebies

   idea stolen from here:
   http://blog.nitrous.io/2013/08/30/using-jekyll-plugins-on-github-pages.html
"
for i in 5 4 3 2 1 0; do
  echo $i...
  sleep 1
done

# Build the _site
jekyll build
# Move it to temp storage
mkdir -p $gh_tmpdir
mv _site/* $gh_tmpdir
# now checkout branch and wipe it out
git checkout -B gh-pages && rm -r *
# move tmp directory back
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
