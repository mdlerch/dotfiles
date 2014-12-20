if (interactive() & Sys.getenv("TERM")!="") {
    options(vimcom.verbose = 0)
    # options(vimcom.vimpager = FALSE)
    library(vimcom)
    library(colorout)
    library(rlerch)
    # options(pager = "vimrpager")
    #if (Sys.getenv("VIM_PANE") != "")
    #{
    #   options(help_type = "text", pager = vim.pager)
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

create <- function(...) devtools::create(..., rstudio = F)

updatevimcom <- function() devtools::install_github("jalvesaq/vimcom")

myvimcom <- function(branch) devtools::install_bitbucket("mdlerch/VimCom", branch)
rlerch <- function() devtools::install_github("mdlerch/rlerch")

# vim:ft=r
