# r-bookdown

Dockerfile based on [conoria/alpine-pandoc](https://hub.docker.com/r/conoria/alpine-pandoc/) adding [R](https://www.r-project.org/)and [bookdown](https://bookdown.org/). There is also an example of the `.gitlab-ci.yml` file to build a book and publish as a Gitlab page. Note that this build does not include LaTeX, so it is only useful for building HTML books. Not PDF. 
