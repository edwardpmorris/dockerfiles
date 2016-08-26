# r-bookdown

Dockerfile based on [conoia/alpine-pandoc](https://hub.docker.com/r/conoria/alpine-pandoc/) including [pandoc](http://pandoc.org/) and [bookdown](https://bookdown.org/). There is also an example of the `.gitlab-ci.yml` file to build a book and publish as a Gitlab page. Note that this build does not include LaTeX, so it is only useful for building HTML books. Not PDF. 
