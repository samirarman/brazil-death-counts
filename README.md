# Dados de óbitos obtidos do Portal da transparência do Registro Civil brasileiro
### Limitações:

Os dados estão na forma em que foram "raspados" do [portal da transparência do Registro Civil Brasileiro](https://transparencia.registrocivil.org.br/registros), sem nenhum tratamento.

**IMPORTANTE: Antes de usar os dados, trate os dados e faça as verificações estatísticas necessárias!**

Um relatório de "sanidade" básico pode ser encontrado [aqui](./sanity_check.html).

### Dados disponíveis:

**- scraped_data/cities**: Certidões de óbito emitidas em cada cidade, mês a mês, de janeiro de 2015 até junho de 2020. 

Corresponde a preencher os campos "Ano", "Mês" e "Estado" no portal do Registro Civil. Ex.: 2019, Janeiro, Todas, São Paulo.

**- scraped_data/cities_summary**: Certidões de óbito emitidas em cada cidade, ano a ano, de 2015 até 2020. 

Corresponde a preencher os campos  "Ano" e "Estado" no portal do Registro Civil. Ex.: 2019, Todos, Todas, São Paulo.

**- scraped_data/states**: Certidões de óbito emitidas em cada estado brasileiro, mês a mês, de janeiro de 2015 até junho de 2020. 

Corresponde a preencher os campos  "Ano" e "Mês" no portal do Registro Civil. Ex.: 2019, Janeiro, Todas, Todos.

**- scraped_data/states_summary**: Certidões de óbito emitidas em cada estado, ano a ano, de janeiro de 2015 até junho de 2020. 

Corresponde a preencher os campos  "Ano" no portal do Registro Civil. Ex.: 2019, Todos, Todas, Todos.

**-merged_data/cities.csv**: Merge dos arquivos disponíveis em scraped_data/cities em um único arquivo.

**-merged_data/cities_summary.csv**: Merge dos arquivos disponíveis em scraped_data/cities_summary em um único arquivo.

**-merged_data/states.csv**: Merge dos arquivos disponíveis em scraped_data/states em um único arquivo.

**-merged_data/states_summary.csv**: Merge dos arquivos disponíveis em scraped_data/states_summary em um único arquivo.

### Código-fonte:

A "raspagem" é realizada de forma semi-automática. Cada 'job' deve ser manualmente configurado.

O código utilizado para a "raspagem" está disponível em 'R/' e 'jobs'. Cada script em 'jobs' foi personalizado para um tipo de "raspagem".

O arquivo 'RStudio_job_poster.R' pode ser utilizado para postar simultaneamente os scripts em 'jobs' na funcionalidade 'Jobs' do RStudio.

O arquivo 'make_sanity_check.R' contém um plano do pacote *drake* para gerar o relatório sanity_checks.html de forma automatizada. Antes de utilizá-lo, crie um pasta '.drake' dentro do pasta principal para armazenar os *caches*, caso contrário, o *drake* criará os *caches* na sua pasta pessoal.
