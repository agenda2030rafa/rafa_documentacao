##################### Starspace #######################
dados <- read.csv("dados/df_completo_limpo.csv",header=T, dec=".",sep=";")
dados = dados[,-1]

dados = dados %>% 
  filter(nchar(texto) > 10)

###conjunto de treino
ods_split <- dados %>%
  initial_split()

ods_treino = training(ods_split) #dados #training(ods_split)
ods_teste = testing(ods_split)

model <- ruimtehol::embed_tagspace(x = ods_treino$texto
                                   ,y = ods_treino$ods_16
                                   ,dim = 1000
                                   ,epoch = 100
                                   ,lr = 0.1
                                   ,loss = 'softmax'
                                   ,negSearchLimit = 1
                                   ,ws = 5
                                   ,minCount = 5
)

x11(width = 20, height = 20)
plot(model)

dict <- starspace_dictionary(model)
str(dict)

length(dict$labels)

emb <- as.matrix(model)
dim(emb)

emb_words <- as.matrix(model, type = "words")
emb_labels <- as.matrix(model, type = "labels", prefix = FALSE)

#pegando o embedding de uma palavra específica
recurso_emb <- starspace_embedding(model, 
                                   x = c(1, "recurso"), 
                                   type = "ngram")

#embedding texto inteiro
texto <- c("Recurso extraordinário. Repercussão geral. Propriedade industrial",
           "Existência de repercussão geral")
texto_emb <- starspace_embedding(model, texto)
dim(texto_emb)


#predição
ods_teste = ods_teste %>% 
  filter(nchar(texto) > 10)

pred = predict(model, ods_teste$texto[1])

pred = as.integer((pred[[1]]$prediction)[1,1])

nrow(ods_teste)

vetor_pred = c()
for(i in 1:nrow(ods_teste)){
  pred = predict(model, ods_teste$texto[i])
  pred = as.integer((pred[[1]]$prediction)[1,1])
  vetor_pred[i] = pred
}

acc_16 = 1-(sum(abs(vetor_pred - ods_teste$ods_16))/length(vetor_pred))

acc_16
