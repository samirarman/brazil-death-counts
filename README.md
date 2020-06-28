# `brazil-death-data`

Base de dados de óbitos *"raspada"* do [Portal da Transparência do Registro Civil](https://transparencia.registrocivil.org.br/registros) e o código-fonte usado.

## Base de dados

Pode ser encontrada no [data.world](https://data.world/samirarman/brazil-death-data) ou neste repositório.

Neste repositório você encontra os seguintes diretórios:

- `scraped_data`: *raw data* da raspagem.

- `merged_data`: os mesmos dados, porém agrupados em quatro tabelas.

Mais informações sobre a estrutura dos dados estão [aqui](https://samirarman.github.io/brazil-death-data)


**Lembre-se: os dados são *RAW DATA* e por natureza são incompletos. Faça os ajustes de tratamentos estatísticos necessários.**

Acompanhe as atualizações nos dados através dos *commits*. Os dados no [data.world](https://data.world/samirarman/brazil-death-data) são atualizados automaticamente através deste repositório.

## Código-fonte

O processo de raspagem é semi-automático, ou seja, você deve configurar um *script* e deixar o `R` fazer o resto.

Os *scripts* utilizados estão em `jobs`. Use um ou escreva outro com base em um dos existentes.

### Utilizando um dos *scripts* 

Modifique o seguinte: 

- Escolha um browser e uma porta: 
```r 
rs <- rsDriver(browser = "firefox", port = 2001L) 
```
- Escolha como preencher os campos no site do Registro Civil e onde salvar os dados (a flag `write` indica se os dados devem ser salvos em disco):
 ```r 
 options <-
  expand_grid(
    year = "2020",
    month = "Janeiro",
    region = "Todas",
    state = STATES,
    write = TRUE,
    path = "scraped_data/cities_monthly/"
  ) %>%
  as_tibble()
  ```
  
  - Rode o script no `R` diretamente no console: 
  ```r 
  source("my_script.R")
  ``` 
  - Ou use sua IDE preferida para fazer o "source" do script.
  
  O *script* `merge_data.R` é uma plano do pacote `{drake}` para automatizar a criação do conteúdo do diretório `merged_data`.
  
  Antes de usá-lo, crie um diretório `.drake` no diretório-raiz do projeto para servir de *cache* para o `{drake}`.
  
  O *script* `RStudio_job_poster.R` serve para tirar vantagem da funcionalidade `jobs` do RStudio, permitindo postar mais de um *script* de raspagem simultaneamente. Use com sabedoria para não ser ejetado do servidor.
