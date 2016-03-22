source('./functions.R')

args = commandArgs(trailingOnly=TRUE)

if (length(args) != 1) {
  stop("Give appropriate arguments.")
} else if (length(args) == 1){
  text = args[1]
}

invoke_tagger(text = text)
