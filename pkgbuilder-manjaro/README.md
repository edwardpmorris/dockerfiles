# pkgbuilder

This image provides a clean base Manjaro image used to test makepkg. Inspired by [dkubb/haskell-builder](https://github.com/dkubb/haskell-builder), with some commands cribbed form [zalox/manjaro](https://hub.docker.com/r/zalox/manjaro/). The image uses pacaur to resolve makepkg dependencies so that packages that depend on other packages in the AUR.
