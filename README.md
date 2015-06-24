[SLIDES IS WAT PLANTS CRAVE](http://mundaneprogramming.github.io/slides/)

For [Mundane Programming SRCCON 2015](http://mundaneprogramming.github.io/)

----------



# Dev instructions

## Preview locally

To run Jekyll on localhost:4000

    jekyll serve

### How to deploy to Github pages

e.g. http://mundaneprogramming.github.io/slides

Because this Jekyll instance uses plugins, Github Pages __does not__ automatically update the Github Pages site. So instead, I run the hacky [ghdirty.sh](ghdirty.sh) script, which runs `jekyll build`, creates a temporary directory...and does some `rm -r` and `git push --force` action...so yes, theoretically dangerous. It only needs to be run to update the slides on the live Github Pages site though.

### How to add posts

Edit files in [_posts](_posts/) directory. Only necessary to keep them in this convention:

    1-1-1-[slidenum]-[arbitrary slug].md

e.g.

    1-1-1-1-hello.md
    1-1-1-2-stuff.md
    


## NOTES

Don't use "Note:" because apparently that sets off speaker notes (anything after Note: will not appear in slides)


Uses: 

- [reveal.js 3.1.0](https://travis-ci.org/hakimel/reveal.js) 
- [reveal-jekylljs](https://github.com/dploeger/jekyll-revealjs)
