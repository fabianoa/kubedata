# Apache Airflow

O Apache Airflow é uma ferramenta open source de orquestração para pipelines de dados que teve seu início como uma ferramenta desenvolvida pelo Airbnb. A ferramenta foi desenvolvida em python e a criação dos workflows é via python scripts. Apache Airflow usa gráficos acíclicos direcionados (do inglês Directed Acyclic Graphs, DAG) para gerenciar o fluxo da orquestração e pode ser dividido nos seguintes componentes:

* **airflow-scheduler**: O scheduler monitora todas as tarefas e DAGs que são lançadas uma vez que as dependências são completadas

*  **airflow-worker**: O worker é o processo encarregado da execução das tarefas. Constitui a unidade de escalonamento de airflow, sendo possível distribuirmos várias instâncias na rede.
*  **airflow-webserver**: Ferramenta que fornece a interface gráfica para interagir com o Apache Airflow.
* **git-sync**: Utilitário de sincronização de DAGs com o git. 

Este documento apresenta proposta de  deployment de componente Apache Airflow para a plataforma de Big Data SEMA-DF.

## Instalação

### Pré-requisitos

* Git instalado
* kubectl instalado 

### Procedimento

Faça um clone deste repositório. Vá para a pasta ``deployments/airflow`` e execute os seguintes passos:


Crie namespace para abrigar a aplicação  Airflow, conforme comando abaixo:

```
kubectl create namespace airflow-bigdata

```

Execute  o deployment, executando os comandos abaixo:

```
kubectl apply -n airflow-bigdata  -f postgres-airflow.yaml
kubectl apply -n airflow-bigdata  -f airflow-cfg.yaml
kubectl apply -n airflow-bigdata  -f airflow-deployment.yaml
```

Após o término do deployment, acesse a interface do Nifi pela url  https://airflow-bigdata.app.sema.df.gov.br/


## Segurança

Todo acesso ao Airflow é feito mediante configuração de grupos LDAP. Para utilizar o Airflow, cadastre um usuario no LDAP (https://openldap-ui-bigdata.app.sema.df.gov.br/)
e adicione o mesmo em um dos seguintes grupos:

* **AirflowAdmin** - Usuarios administradores do Airflow (acesso a todas as funcionalidades)
* **AirflowViewer** - Usuarios comuns que podem apenas visualizar os dataflows.
* **AirflowUser** - Usuarios com as mesmas permissões do Viewer e permissões de criar DAGS.
* **AirflowOp** - Usuarios com  permissões de Users e permissões de realizar configurações no ambiente.

Caso se tenha a necessidade de criar um novo perfil de usuario , será necessário criar um grupo na OU  ``Airflow,ou=Groups,dc=sema,dc=df,dc=gov,dc=br`` e mapear o grupo para uma Role do airflow no arquivo `webserver_config.py` (ver airflow-cfg.yaml).


## Persistencia de Dados e configurações 

Para fins de persistência dos dados do Airflow, temos  os seguintes volumes:


| Nome | Ponto de Montagem | Tamanho Mínino | Descrição | 
|---|---|---|---| 
| airflow-dags-pvc | /sync-dags | 1 Gb | Local onde os DAGs são armazenados. |  
| postgres-pv-claim | /var/lib/postgresql/data | 5 Gb | Local onde os metadados do Airflow são armazenados (banco psotgres). | 

Recomenda-se a realização de backups periódicos e/ou antes de atualizações/mudanças neste serviço.

## Outras informações

Esta instância do Airflow esta configurado para sincronizar os DAGs a partir do repositorio git https://gitlab.xskylab.com/bigdata/sema-df/airflow-dags.git. Para adicionar qualquer DAG ao Airflow, faça a adição do mesmo neste repositório. 


## Referências

* https://airflow.apache.org/