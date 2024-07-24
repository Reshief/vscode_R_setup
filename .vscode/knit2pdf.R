#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

using <- function(...) {
    libs <- unlist(list(...))
    req <- unlist(lapply(libs, require, character.only = TRUE))
    need <- libs[req == FALSE]
    n <- length(need)
    if (n > 0) {
        libsmsg <- if (n > 2) paste(paste(need[1:(n - 1)], collapse = ", "), ",", sep = "") else need[1]
        print(libsmsg)
        install.packages(need, repos = "https://ftp.fau.de/cran/")
        lapply(need, require, character.only = TRUE)
    }
}

# Load libraries
using("optparse", "knitr", "tinytex")

# Get arguments from command line
option_list <- list(
    make_option(c("-f", "--file"),
        type = "character", default = NULL,
        help = "Input file path", metavar = "character"
    ),
    make_option(c("-o", "--out"),
        type = "character", default = NULL,
        help = "Output file name", metavar = "character"
    )
)


opt_parser <- OptionParser(option_list = option_list)
opt <- parse_args(opt_parser)

# Actually perform knit2pdf
knit2pdf(opt$file)
