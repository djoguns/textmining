# Extracting Text from pdf - files collection

load.lib <- c("pdftools", "magrittr", "dplyr", "lubridate", "twitteR", "plotly", "tm", "wordcloud", "syuzhet", "streamR", "RCurl", "RJSONIO", "stringr", "rjson", "ROAuth", "ggplot2", "ggthemes", "Amelia", "plyr", "bit64")
install.lib <- load.lib[!load.lib %in% installed.packages()]
for(lib in install.lib) install.packages(lib,dependences=TRUE)
sapply(load.lib,require,character=TRUE)

library(pdftools)
library(magrittr) # The infix operator %>% is not part of base R, but it is defined by the package magrittr...

file_vector <- list.files(path = "Data/")

file_vector %>% head() # head(file_vector) does the same

grepl(".pdf", file_vector)

pdf_list <- file_vector[grepl(".pdf", file_vector)]

head(pdf_list)

# Checking out text in a document
pdf_text("data/BUSINESSCENTER.pdf")

pdf_text("data/BUSINESSCENTER.pdf") %>% strsplit(split = "\n")

corpus_raw <- data.frame("company" = c(),"text" = c())

for (i in 1:length(pdf_list)){
  print(i)
  pdf_text(paste("Data/", pdf_list[i], sep = "")) %>% strsplit("\n")-> document_text
  data.frame("company" = gsub(x =pdf_list[i],pattern = ".pdf", replacement = ""), 
             "text" = document_text, stringsAsFactors = FALSE) -> document
  colnames(document) <- c("company", "text")
  corpus_raw <- rbind(corpus_raw,document) 
}

corpus_raw %>% head()

