library(tm)
library(lda)
library(LDAvis)
source('/home/shubhankar/TextMining/GSOC-Tests/get_text.R')

f = "/home/shubhankar/data/pg100.txt"
url = "http://www.gutenberg.org/cache/epub/2243/pg2243.txt"

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

serVis(json, out.dir = 'vis', open.browser = TRUE)