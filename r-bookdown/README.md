# r-bookdown

[![](https://images.microbadger.com/badges/version/conoria/r-bookdown.svg)](http://microbadger.com/images/conoria/r-bookdown "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/conoria/r-bookdown.svg)](http://microbadger.com/images/conoria/r-bookdown "Get your own image badge on microbadger.com")

Dockerfile based on [jangorecki/r-base-dev](https://hub.docker.com/r/jangorecki/r-base-dev/) including [pandoc](http://pandoc.org/) 1.13.1 and [bookdown](https://bookdown.org/). There is also an example of the `.gitlab-ci.yml` file to build a book and publish as a Gitlab page. Note that this build does not include LaTeX, so it is only useful for building HTML books. Not PDF. 
