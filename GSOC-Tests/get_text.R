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
  
  for (i in text){
    print (i)
  }
}

f = "/home/shubhankar/data/gutenberg_page.txt"
url = "http://www.gutenberg.org/cache/epub/2243/pg2243.txt"

get_text(f,url)
