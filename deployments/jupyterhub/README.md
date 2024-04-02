# JupyterHub

O JupyterHub é uma aplicação de código aberto que permite criar e gerenciar múltiplas instâncias do Jupyter Notebook. Ele é projetado para ser implantado em um servidor e fornecer uma plataforma para hospedar ambientes colaborativos de notebooks baseados em Jupyter.

O Jupyter Notebook é uma interface interativa baseada na web que permite a criação e execução de código em diferentes linguagens de programação, como Python, R e Julia. É amplamente utilizado para exploração de dados, prototipagem, visualização e análise.

Este documento apresenta proposta de  deployment de componente JupyterHub para a plataforma de Big Data SEMA-DF.

## Instalação

### Pré-requisitos

* Git instalado
* kubectl instalado 
* helm instalado

### Procedimento

Faça um clone deste repositório. Vá para a pasta ``deployments/jupyterhub`` e execute os seguintes passos:


Crie namespace para abrigar a aplicação  JupyterHub, conforme comando abaixo:

```
kubectl create namespace jupyterhub-bigdata

```

Obtenha o heml chart que será utilizado na instalação:

```
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update
```

Execute  o deployment, executando os comandos abaixo:


```
helm upgrade --install --values config.yaml jupyterhub jupyterhub/jupyterhub --namespace jupyterhub-bigdata

kubectl apply -n jupyterhub-bigdata  -f jupyterhub-ingress.yaml
```

Após o término do deployment, acesse a interface do Apache Zeppelin pela url  https://jupyterhub-bigdata.app.sema.df.gov.br


## Segurança

Todo acesso ao Superset é feito mediante configuração de grupos LDAP. Para utilizar o Superset, cadastre um usuario no LDAP (https://openldap-ui-bigdata.app.sema.df.gov.br/)
e adicione o mesmo em um dos seguintes grupos:

* Users - Usuarios do JupyterHub


## Persistencia de Dados e configurações 

Para fins de persistência dos dados do Superset, temos  os seguintes volumes:

| Nome | Ponto de Montagem | Tamanho Mínino | Descrição | 
|---|---|---|---| 
| hub-db-dir |  | 1Gi | Local onde os metadados  do Jupyterhub serão persistidas. | 

Recomenda-se a realização de backups periódicos e/ou antes de atualizações/mudanças neste serviço.








