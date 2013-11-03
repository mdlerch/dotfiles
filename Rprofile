if (interactive() & Sys.getenv("TERM")!="") {
	library(vimcom.plus)
	library(colorout)
}

# library(grDevices)
# X11.options(type="nbcairo")

options(repos=c("http://cran.fhcrc.org/","http://cran.cs.wwu.edu/"))

cd <- setwd
pwd <- getwd
h <- utils::head
man <- utils::help

logit <- function(x) log(x / (1 - x))
ilogit <- function(x) exp(x) / (1 + exp(x))
