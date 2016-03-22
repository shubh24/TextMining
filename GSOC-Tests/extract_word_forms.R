source('./functions.R')

args = commandArgs(trailingOnly=TRUE)

if (length(args) != 2) {
  stop("Give appropriate arguments.")
} else if (length(args) == 2){
  text = args[1]
  part_of_speech = args[2]
}

get_part_of_speech(text, part_of_speech = part_of_speech)
