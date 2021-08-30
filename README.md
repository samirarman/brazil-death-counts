# `brazil-death-data`

Base de dados de óbitos *"raspada"* do [Portal da Transparência do Registro Civil](https://transparencia.registrocivil.org.br/registros) ("dados dos cartórios") e o código-fonte usado.

O objetivo deste projeto é facilitar o acesso à base de dados do registro civil enquanto não existir API disponível para consulta ou atualização do sistema SIM do SUS.

Os dados podem ser encontrados no [data.world](https://data.world/samirarman/brazil-death-data) ou neste repositório, no diretório `merged_data`.

O [data.world](https://data.world/samirarman/brazil-death-data) fornece algumas ferramentas simples para visualização e consultas diretamente no navegador, sem necessidade de utilizar softwares externos

**Os dados são fornecidos "como estão". Faça as verificações necessárias.**

### Tabelas disponíveis

Quatro tabelas estão disponíveis:

* *by_city_monthly*: óbitos registrados em cada cidade, mês a mês.
* *by_city_yearly*: óbitos registrados em cada cidade, ano a ano.
* *by_state_monthly*: óbitos registrados em cada estado, mês a mês.
* *by_state_yearly*: óbitos registrados em cada estado, ano a ano.

### Leitura direta para o R e Python

#### R
```r
city_monthly <- read.csv("https://github.com/samirarman/brazil-death-data/raw/master/merged_data/by_city_monthly.csv")
city_yearly <- read.csv("https://github.com/samirarman/brazil-death-data/raw/master/merged_data/by_city_yearly.csv")
state_monthly <- read.csv("https://github.com/samirarman/brazil-death-data/raw/master/merged_data/by_state_monthly.csv")
state_yearly <- read.csv("https://github.com/samirarman/brazil-death-data/raw/master/merged_data/by_state_yearly.csv")
```
#### Python
```python
import pandas as pd
city_monthly = pd.read_csv("https://github.com/samirarman/brazil-death-data/raw/master/merged_data/by_city_monthly.csv")
city_yearly = pd.read_csv("https://github.com/samirarman/brazil-death-data/raw/master/merged_data/by_city_yearly.csv")
state_monthly = pd.read_csv("https://github.com/samirarman/brazil-death-data/raw/master/merged_data/by_state_monthly.csv")
state_yearly = pd.read_csv("https://github.com/samirarman/brazil-death-data/raw/master/merged_data/by_state_yearly.csv")
```

### Atualizações

Os dados são atualizados automaticamente às segundas-feiras. 
