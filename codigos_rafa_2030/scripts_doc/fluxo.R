########################## pacotes - nem todos sao necessarios aqui
library(tidytext)
library(tidyverse) 
library(stringr) 
library(quanteda) 
library(forcats) 
library(ggthemes) 
library(purrr)
library(foreach)
library(tokenizers)
library(stringi)
library(quanteda.textmodels)
library(tm)
library(stylo)
library(SnowballC)
library(caret)
library(doParallel)
library(readxl)
library(reshape2)
library(udpipe)
library(lattice)
library(lubridate)
library(data.table)
library(magrittr)
library(textstem)
library(tidytext)
library(ruimtehol)
library(sjmisc)
library(stopwords)
library(rslp)
library(keras)
library(tidymodels)
library(tensorflow)
library(pdftools)
library(purrr)
library(textrecipes)
library(quanteda.textstats)
library(tfdatasets)
library(reticulate)
#remotes::install_github("jjesusfilho/justop")
library(justop)
library(devtools)
library(ggthemes) 
library(tokenizers)
library(tesseract)
library(textrank)
library(igraph)
library(ggraph)
library(wordcloud)
library(qdapRegex)
library(textclean)
library(filesstrings)
###################### pasta onde se encontram peticoes e acordaos
#trocar o caminho da pasta de origem - aqui temos um exemplo ficticio
setwd("caminho/pasta/peticoes_acordaos_pdf")
getwd()

file_list <- list.files(pattern = "*.pdf")

##################### funcoes
#supondo que os arquivos tenham _P ou _A indicando peticoes ou acordaos, respec.
limpa_nome = function(x){
  if(grepl("_P", x, fixed = TRUE) == T){
    nome = stri_match_first_regex(x, "(.*?)\\_P")[,2]
    nome = gsub("_","",nome)
  } else {
    nome = stri_match_first_regex(x, "(.*?)\\_A")[,2]
    nome = gsub("_","",nome)
  }
  
  return(nome)
}

pet = function(x){
  if(grepl("_P", x, fixed = TRUE) == T){
    valor = 1
  } else {
    valor = 0
  }
  return(valor)
}

acord = function(x){
  if(grepl("_A", x, fixed = TRUE) == T){
    valor = 1
  } else {
    valor = 0
  }
  return(valor)
}

#teste - função limpa_nome
limpa_nome(file_list[1])

###################### leitura da base - arquivo baixado do hotsite agenda 2030 no STF
tabela <- read_excel("nome_arquivo_baixado_hotsite.xlsx")

##################### teste - Movimentacao de arquivos
caminho = paste("caminho/pasta/peticoes_acordaos_pdf",file_list[1],sep = "")
caminho

file.move(caminho, "pasta/criada/para/peticoes")

###################### laco de repeticao
tabela_dist = distinct(tabela, ID, .keep_all = T)

system.time({
  
for(i in 1:nrow(tabela_dist)){
  nome = tabela_dist$ID[i]
  for(j in 1:length(file_list)){
    if(nome == limpa_nome(file_list[j])){
      if(pet(file_list[j]) == 1){
        caminho = paste("caminho/pasta/peticoes_acordaos_pdf",file_list[j],sep = "")
        file.move(caminho, "pasta/criada/para/peticoes")
      }
      if(acord(file_list[j]) == 1){
        caminho = paste("caminho/pasta/peticoes_acordaos_pdf",file_list[j],sep = "")
        file.move(caminho, "pasta/criada/para/acordaos")
      }
    }
  }
}

})
