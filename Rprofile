if (interactive() & Sys.getenv("TERM")!="") {
    # options(nvimcom.verbose = 0)
    options(nvimcom.verbose = 0)
    # options(vimcom.vimpager = FALSE)
    library(nvimcom)
    # library(colorout)
    library(rlerch)
    # options(pager = "vimrpager")
    #if (Sys.getenv("VIM_PANE") != "")
    #{
    #   options(help_type = "text", pager = vim.pager)
    #}
}

# library(grDevices)
# X11.options(type="nbcairo")

local({r <- getOption("repos"); r["CRAN"] <- "http://cran.fhcrc.org/"; options(repos = r)})

options(menu.graphics = F)
options(continue = "++   ")

# complete library names
utils::rc.settings(ipck = TRUE)

cd <- setwd
pwd <- getwd
h <- utils::head
man <- utils::help
l <- base::list

less <- function() options(pager = "less")

create <- function(...) devtools::create(..., rstudio = F)

updatevimcom <- function() devtools::install_github("jalvesaq/nvimcom")

myvimcom <- function(branch="master") devtools::install_bitbucket("mdlerch/nvimcom", branch)
updaterlerch <- function() devtools::install_github("mdlerch/rlerch")

# vim:ft=r
