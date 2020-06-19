![.github/workflows/main.yml](https://github.com/samirarman/brazil-death-data/workflows/.github/workflows/main.yml/badge.svg)
O "scrape" é realizado de forma semi-automática. Cada 'job' deve ser manualmente configurado.

O código utilizado para a "raspagem" está disponível em 'R/' e 'jobs'. Cada script em 'jobs' foi personalizado para um tipo de "raspagem".

O arquivo 'RStudio_job_poster.R' pode ser utilizado para postar simultaneamente os scripts em 'jobs' na funcionalidade 'Jobs' do RStudio.

O arquivo 'merge_data.R' é utilizado para unir as tabelas e gerar um reporte do resultado do operação de "scrape" dos dados.

Para o estado de Mato Grosso, é necessária seleção manual no portal do Registro Civil, caso contrário os dados serão referentes ao estado de Mato Grosso do Sul.
