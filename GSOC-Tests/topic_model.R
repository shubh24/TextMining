source('./functions.R')

args = commandArgs(trailingOnly=TRUE)

if (length(args) < 1) {
  stop("First argument - FileName. Second argument - URL")
} else if (length(args) == 1){
  f = args[1]
  generate_topic_models(f)
} else if (length(args) == 2) {
  f = args[1]
  url = args[2]
  generate_topic_models(f,url)
}

