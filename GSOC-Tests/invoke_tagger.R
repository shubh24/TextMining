library(openNLP)
library(NLP)

invoke_tagger = function(text){
  
  sentence_tokenizer <- Maxent_Sent_Token_Annotator()
  word_tokenizer <- Maxent_Word_Token_Annotator()
  pos_tag_tokenizer <- Maxent_POS_Tag_Annotator(probs = TRUE)
  
  tokenizers <- annotate(text, list(sentence_tokenizer, word_tokenizer))
  pos_tags_with_prob = annotate(text, pos_tag_tokenizer, tokenizers)
  
  #print(pos_tags_with_prob)
  return(pos_tags_with_prob)
}
