library(stringr)
library(magrittr)
library(stringi)
library(reticulate)
library(keras)
#py_config
#use_python("/home/ro/anaconda3/envs/my_env/bin/python")
library(hash)


my_txt <- readLines(paste( "/media/ro/TOSHIBA EXT/ro/Downloads/",
                           "pwned-passwords-sha1-ordered-by-count-v4.txt",sep = ""), n = 1000) %>%
  
  str_split_fixed( ":", 2)

colnames(my_txt) <- c("Clave secreta (Hash)", "Cantidad")

df <- as.data.frame(str_split_fixed(my_txt[,1], "", 40))

df <- data.frame(my_txt[,1],df)
 

myLetters <- LETTERS[1:26]

l <-  lapply(df[,-1],match,  myLetters)
l <- as.data.frame(l)
l[is.na(l)] <- 0

l2 <- lapply(df[,-1],as.numeric)

target=df[,1]
df  <- data.frame(target,l,l2)

index<- sample (1: nrow(df),floor(0.7*nrow(df)))

df_train <- df[index,]
df_test <- df[-index,]      

gradient.color <- list(low = "steelblue",  high = "white")

df_train[, -1] %>%    
  scale() %>%     
  get_clust_tendency(n = 50, gradient = gradient.color)




