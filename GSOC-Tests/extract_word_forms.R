source('./invoke_tagger.R')

get_part_of_speech = function(text, part_of_speech){
  
  pos_tags_with_prob = invoke_tagger(text)
  words = subset(pos_tags_with_prob, type == "word")  
  pos_to_check = substring(part_of_speech,1,1)
  
  for (i in 1:length(words)){
    if (substring(words$features[i][[1]][1],1,1) == pos_to_check){
      print(substring(text,words$start[i],words$end[i]))
    }
  }
}

#get_part_of_speech("I am a boy.", "VERB")

