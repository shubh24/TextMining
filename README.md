# TextMining
Tasks for GSOC - Integration of Text Mining and Topic Modeling Tools

# Installation
```bash
$ git clone https://github.com/shubh24/TextMining/
$ cd TextMining/GSOC-Tests/
```

# Test the code

 - Task 1 -- Get Text
 ```bash
 $ Rscript get_text.R <file_name> <url_source>
 ```
 Example
 ```bash
 $ Rscript get_text.R "./jane.txt" "http://www.gutenberg.org/cache/epub/1342/pg1342.txt"
 ```
 
 - Task 2 -- Invoke Tagger
  ```bash
  $ Rscript invoke_tagger.R <text>
  ```
  Example
  ```bash
  $ Rscript invoke_tagger.R "He is a boy. She is a girl." 
  ```
  
 - Task 3 -- Extract Verb/Noun Forms
 ```bash 
 $ Rscript extract_word_forms.R <text> <Part-of-Speech>
 ```
 Example
  ```bash
  $ Rscript extract_word_forms.R "He is a boy. She is a girl." "NOUN"
  ```
    
 - Topic Modelling (Extra Task)
 ```bash 
 $ Rscript topic_model.R <file_name> #if file already exists
 $ Rscript topic_model.R <file_name> <URL_Source> #if file doesn't exist, first extract.
 ```

 Example
 ```bash
 $ Rscript topic_model.R "./jane.txt"
 $ Rscript topic_model.R "./jane.txt" "http://www.gutenberg.org/cache/epub/1342/pg1342.txt"  
 ```
  
 # Topic Modelling
 
 -The LDAvis package is used for visualization purposes.
 -After running topic_model script, open "127.0.0.1:4321" to view the model.
  
  
  
