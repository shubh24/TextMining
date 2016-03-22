args = commandArgs(trailingOnly=TRUE)

if (length(args) != 2) {
  stop("Give appropriate arguments.")
} else if (length(args) == 2){
  url = args[2]
  f = args[1]
}

get_text(f,url)
