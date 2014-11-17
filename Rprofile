if (interactive() & Sys.getenv("TERM")!="") {
    options(vimcom.verbose = 0)
	library(vimcom)
	library(colorout)
	# options(pager = "vimrpager")
	#if (Sys.getenv("VIM_PANE") != "")
	#{
	#	options(help_type = "text", pager = vim.pager)
	#}
}

# library(grDevices)
# X11.options(type="nbcairo")

options(repos=c("http://cran.fhcrc.org/","http://cran.cs.wwu.edu/"))

options(menu.graphics = F)
options(continue = "++   ")

cd <- setwd
pwd <- getwd
h <- utils::head
man <- utils::help
l <- base::list

less <- function() options(pager = "less")

logit <- function(x) log(x / (1 - x))
ilogit <- function(x) exp(x) / (1 + exp(x))

create <- function(...) devtools::create(..., rstudio = F)

updatevimcom <- function() devtools::install_github("jalvesaq/vimcom")

myvimcom <- function() devtools::install_bitbucket("VimCom", "mdlerch")

# vim:ft=r
