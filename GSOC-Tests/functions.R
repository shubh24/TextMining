if(!require('openNLP')){install.packages('openNLP')}
if(!require('NLP')){install.packages('NLP')}
if(!require('tm')){install.packages('tm')}
if(!require('lda')){install.packages('lda')}
if(!require('LDAvis')){install.packages('LDAvis')}
requireNamespace('servr')

get_text = function(file_name, url){
  
  #Downloading the specified page in Gutenberg's corpus. 
  if (!file.exists(file_name)){
    download.file(url = url, destfile = file_name)
  }
  
  text = readLines(file_name)
  
  #Merging all lines together
  text = paste(text, collapse = " ")
  
  #To remove all text within "<< >>" -- License
  text = strsplit(text, "<<[^>]*>>")[[1]]
  return (text)
  
}


invoke_tagger = function(text){
  
  sentence_tokenizer <- Maxent_Sent_Token_Annotator()
  word_tokenizer <- Maxent_Word_Token_Annotator()
  pos_tag_tokenizer <- Maxent_POS_Tag_Annotator(probs = FALSE)
  
  tokenizers <- annotate(text, list(sentence_tokenizer, word_tokenizer))
  pos_tags_with_prob = annotate(text, pos_tag_tokenizer, tokenizers)
  
  return(pos_tags_with_prob)
}

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


generate_topic_models = function(f,url = NULL){
  
  corpus = Corpus(VectorSource(get_text(file_name = f, url = url)))
  corpus = tm_map(corpus, content_transformer(tolower))
  corpus = tm_map(corpus, removePunctuation)
  corpus = tm_map(corpus, stripWhitespace)
  corpus = tm_map(corpus, removeWords, stopwords("english"))
  corpus = tm_map(corpus, PlainTextDocument)
  
  dtm = DocumentTermMatrix(corpus) 
  dtms = removeSparseTerms(dtm, 0.80)
  
  text = c()
  for(i in 1:length(corpus)){text = c(text,corpus[[i]]$content)}
  
  doc.list = strsplit(text, "[[:space:]]+")
  vocab = colnames(dtms)
  
  get.terms = function(x) {
    index = match(x, vocab)
    index = index[!is.na(index)]
    rbind(as.integer(index - 1), as.integer(rep(1, length(index))))
  }
  documents = lapply(doc.list, get.terms)
  
  D = length(documents)  
  W = length(vocab)  
  doc.length = sapply(documents, function(x) sum(x[2, ]))
  N = sum(doc.length)
  term.frequency = as.integer(colSums(as.matrix(dtms)))
  
  K = 20
  G = 100 
  alpha = 0.02
  eta = 0.02
  set.seed(1000)
  
  fit = lda.collapsed.gibbs.sampler(documents = documents, K = K, vocab = vocab,num.iterations = G, alpha = alpha, eta = eta, initial = NULL, burnin = 0, compute.log.likelihood = TRUE)
  
  theta = t(apply(fit$document_sums + alpha, 2, function(x) x/sum(x)))
  phi = t(apply(t(fit$topics) + eta, 2, function(x) x/sum(x)))
  
  finalList = list(phi = phi,theta = theta,doc.length = doc.length, vocab = vocab,term.frequency = term.frequency)
  
  json = createJSON(phi = finalList$phi, theta = finalList$theta, doc.length = finalList$doc.length, vocab = finalList$vocab, term.frequency = finalList$term.frequency)
  
  serVis(json, out.dir = './vis', open.browser = TRUE)
}