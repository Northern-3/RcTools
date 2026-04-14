
# RcTools

<!-- badges: start -->

<!-- badges: end -->

The goal of RcTools is to provide a collection of tools (functions) to
be utilised by the Northern Three Report Cards’ technical staff. These
tools bridge the gap between:

1.  Online data resources,
2.  Data analysis pipelines, and
3.  Publication ready figures and tables.

Specifically, the tools focus on tasks such as building commonly used
spatial files, downloading datasets from APIs, calculating scores and
grades, and producing stylised visual products such as plots, maps, and
formatted xlsx files.

A website is available to fully explore what this package has to offer:
[RcTools Website.](https://northern-3.github.io/RcTools/index.html)

# Getting Started

To install this package you will first need to download the [RTools
package](https://cran.r-project.org/bin/windows/Rtools/rtools45/rtools.html)
and install it on your computer (accept the defaults everywhere during
the installation process).

Following this, you can install the development version of RcTools from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("Northern-3/RcTools")
```

Finally, load the package just like you would any other R package:

``` r
library(RcTools)
```

Once you have successfully loaded the package you are good to go!

# Updating the Website

To update the website you will need to clone this repository as normal
and make your edits on your local machine. Before pushing your edits
back to the remote, run the following command:

``` r
usethis::use_pkgdown_github_pages()
```

This will update all of the necessary behind the scenes information for
the website to then be updated.

# Update the README

To update the readme (this document) you will need to clone this
repository as normal and make your edits on your local machine. Before
pushing your edits back to the remote, run the following command:

``` r
devtools::build_readme()
```

This will update all of the necessary behind the scenes information for
the readme to then be updated. Note that this is different to the normal
way of updating the readme.

# Creating/Editing Functions

Creating and editing functions takes a bit more work. Refer to [R
Packages 2nd Edition](https://r-pkgs.org/whole-game.html) to learn more.
