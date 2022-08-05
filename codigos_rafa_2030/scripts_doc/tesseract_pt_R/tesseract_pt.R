# referencia: https://bookdown.org/davi_moreira/txt4cs/scrape.html
# referencia: https://cran.r-project.org/web/packages/tesseract/tesseract.pdf
library(tesseract)

# escolher uma pasta de destino

# tesseract em portugues
tesseract_download('por')

por <- tesseract("por")

# obtendo texto de imagens
text_2 = tesseract::ocr("teste_imagem.JPG", engine = por)
cat(text_2)

# transformando PDF em imagem
img_file <- pdftools::pdf_convert("adpf_56.pdf", format = 'tiff', pages = 1, dpi = 400)

# ou
img_file <- pdftools::pdf_convert("EPCIMAT.pdf", format = 'tiff', pages = 1, dpi = 400)

# obtendo texto da imagem 
text_3 = tesseract::ocr(img_file, engine = por)
cat(text_3)

# limpeza
text = gsub("\r\n", " ", text_3)
text = gsub("\\[|\\]", "", text)
text = gsub('§',' ',text)
text = gsub("º", " ", text)
text = gsub('[.]', " ", text)
text = gsub("-", " ", text)
text = gsub("/", " ", text)
text = gsub("\\\\", "", text)
text = gsub(":", " ", text)
text = gsub(";", " ", text)
text = gsub("[()]", " ", text)
text = gsub("www", " ", text)
text = gsub("’"," ", text)
text = gsub("‘"," ", text)
text = gsub("°", "", text)
text = gsub("“"," ", text)
text = gsub("”"," ", text)
text = gsub('"'," ", text)
text = gsub(','," ", text)
text = gsub("<"," ", text)
text = gsub(">"," ", text)
text = gsub("–"," ", text)
text = gsub("~", "", text)
text = gsub("*", "", text)
text = gsub("_", "", text)
text = gsub("?","", text)
text = gsub("!", "", text)
text = gsub("&", "", text)
text = gsub("$", "", text)
text = gsub("#", "", text)
text = gsub("@", "", text)
text = gsub("=", "", text)
text = gsub("+", "", text)
text = gsub("»", "", text)
text = gsub("%", "", text)
text = gsub("'", "", text)
text = gsub("~~", "", text)
text = gsub("|", "", text)
text = gsub('\\b\\w{1}\\s',' ',text)
text = gsub('—','',text)
text = gsub('?','',text)
text = trimws(text)
text = str_squish(text)
cat(text)
