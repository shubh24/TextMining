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
 
 - Task 2 -- Invoke Tagger
  ```bash
  $ Rscript invoke_tagger.R <text>
  ```
  
  - Task 3 -- Extract Verb/Noun Forms
  ```bash 
  $ Rscript extract_word_forms.R <text> <Part-of-Speech>
  ```
  
  - Topic Modelling (Extra Task)
  ```bash 
  $ Rscript topic_model.R <file_name> #if file already exists
  $ Rscript topic_model.R <file_name> <URL_Source>
  ```
  
  
  