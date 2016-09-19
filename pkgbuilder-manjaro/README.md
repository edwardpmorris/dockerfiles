# pkgbuilder:manjaro

This image provides a clean base Manjaro image used to test makepkg. The base image was generated using [these scripts](https://github.com/edge226/docker/commit/396ae0ed3d8b9c768c141433c08095c94802f1f3) by [@edge266](https://github.com/edge226). The tool itself was inspired by [dkubb/haskell-builder](https://github.com/dkubb/haskell-builder), with some GPG key-related commands cribbed form [zalox/manjaro](https://hub.docker.com/r/zalox/manjaro/). The image uses pacaur to resolve makepkg dependencies so that packages that depend on other packages in the AUR can be installed as if calling `makepkg -s`.

## Usage
Navigate to the folder containing your makefile and execute:
`docker run --rm -v "$(pwd):/src" conoria/pkgbuilder:manjaro`

## Base image date
09/19/16
