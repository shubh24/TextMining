source("./functions.R")
args = commandArgs(trailingOnly=TRUE)

if (length(args) != 2) {
  stop("First Argument - File Name. Second Argument - URL")
} else if (length(args) == 2){
  url = args[2]
  f = args[1]
}

get_text(f,url)
