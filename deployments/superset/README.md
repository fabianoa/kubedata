# Apache Superset

O Apache Superset é uma plataforma de visualização de dados de código aberto que permite explorar e visualizar dados de maneira interativa. Ele fornece uma interface web intuitiva e recursos avançados para criar painéis interativos, gráficos, tabelas e relatórios.

Com o Superset, os usuários podem se conectar a uma ampla variedade de fontes de dados, como bancos de dados relacionais, bancos de dados NoSQL, serviços em nuvem e arquivos CSV. Ele oferece conectores para várias tecnologias de banco de dados, como MySQL, PostgreSQL, SQLite, Oracle, Microsoft SQL Server, Apache Hive, Apache Druid, entre outros.

O Superset permite a criação de visualizações usando uma interface de arrastar e soltar, onde os usuários podem selecionar as colunas de dados, aplicar filtros, definir agregações e escolher o tipo de gráfico desejado. Ele suporta uma ampla gama de tipos de gráficos, incluindo barras, linhas, áreas, dispersões, gráficos de pizza, mapas geográficos e muito mais.

Além disso, o Superset oferece recursos avançados, como painéis interativos e programação de atualização automática dos dados. Isso permite que os usuários criem painéis personalizados com vários gráficos e filtros interativos, além de definir a frequência de atualização dos dados para manter as visualizações sempre atualizadas.

O Superset também possui recursos de segurança e controle de acesso, permitindo que os administradores gerenciem permissões de usuários e grupos, garantindo que apenas as pessoas autorizadas tenham acesso aos dados e painéis.

Este documento apresenta proposta de  deployment de componente Apache Superset para a plataforma de Big Data SEMA-DF.

## Instalação

### Pré-requisitos

* Git instalado
* kubectl instalado 
* helm instalado

### Procedimento

Faça um clone deste repositório. Vá para a pasta ``deployments/superset`` e execute os seguintes passos:


Crie namespace para abrigar a aplicação  Apache Superset, conforme comando abaixo:

```
kubectl create namespace superset-bigdata

```

Obtenha o heml chart que será utilizado na instalação:

```
helm repo add superset https://apache.github.io/superset
helm search repo superset
```

Execute  o deployment, executando os comandos abaixo:


```
helm upgrade --install --values values.yaml superset superset/superset -n superset-bigdata

kubectl apply -n superset-bigdata  -f superset-ingress.yaml

```

Após o término do deployment, acesse a interface do Apache Zeppelin pela url  https://superset-bigdata.app.sema.df.gov.br


## Segurança

Todo acesso ao Superset é feito mediante configuração de grupos LDAP. Para utilizar o Superset, cadastre um usuario no LDAP (https://openldap-ui-bigdata.app.sema.df.gov.br/)
e adicione o mesmo em um dos seguintes grupos:

* SupersetAdmin - Usuarios administradores do Superset(acesso a todas as funcionalidades)
* SupersetAlpha - Ver perfil na documentação na seção  de referências.
* SupersetGamma - Ver perfil na documentação na seção  de referências.
* SupersetSQLLab - Usuario com permissão para usar o SQLLab.


## Persistencia de Dados e configurações 

Para fins de persistência dos dados do Superset, temos  os seguintes volumes:

| Nome | Ponto de Montagem | Tamanho Mínino | Descrição | 
|---|---|---|---| 
| data-superset-postgresql-0 |  | 8Gi | Local onde os metadados  do zeppelin serão persistidas. | 

Recomenda-se a realização de backups periódicos e/ou antes de atualizações/mudanças neste serviço.
