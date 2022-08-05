#Passo a Passo - Instalação Keras e Tensorflow no R

#1.Instalar Anaconda
#2.Criar um env e ativá-lo - chamei o meu de keras_env
#3.Na seta ao lado do nome do env, clicar em open terminal
#4.No terminal, digitar conda install -c anaconda keras
#5.Quando aparecer a opção [y/n], escolher y - Os pacotes serão instalados
#6.Instalar o Jupyter Notebook dentro do env diretamente pelo Anaconda
#7.Abrir um notebook para fazer testes - Meu notebook se chama Teste_Keras_Tensorflow
#8.Passo a Passo até aqui disponível em: https://oindrilasen.com/2021/02/how-to-install-and-import-keras-in-anaconda-jupyter-notebooks/

#9.Instalar os pacotes no RStudio
install.packages("keras")
library(keras)
install.packages("tensorflow")
library(tensorflow)

#Carregar pacotes
library(keras)
library(tensorflow)

#Exemplo - Dataset MNIST
mnist <- dataset_mnist()
x_train <- mnist$train$x
y_train <- mnist$train$y
x_test <- mnist$test$x
y_test <- mnist$test$y
