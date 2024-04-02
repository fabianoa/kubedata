# Apache Zeppelin

O Apache Zeppelin é uma plataforma de código aberto para análise interativa de dados. Ele fornece um ambiente de notebook baseado na web, no qual os usuários podem executar códigos, criar visualizações e colaborar em análises de dados.

O Zeppelin é projetado para trabalhar com várias linguagens de programação, como Scala, Python, R, SQL e muitas outras. Ele oferece suporte a diferentes mecanismos de interpretação e execução, permitindo que você execute consultas em tempo real, visualize os resultados e compartilhe suas análises com outras pessoas.

Além disso, o Zeppelin suporta integração com várias ferramentas e frameworks de processamento de dados, como Apache Spark, Hadoop e Elasticsearch, permitindo que você trabalhe com grandes volumes de dados e execute análises distribuídas.

Este documento apresenta proposta de  deployment de componente Apache Zeppelin para a plataforma de Big Data SEMA-DF.

## Instalação

### Pré-requisitos

* Git instalado
* kubectl instalado 

### Procedimento

Faça um clone deste repositório. Vá para a pasta ``deployments/zeppelin`` e execute os seguintes passos:


Crie namespace para abrigar a aplicação  Apache Zeppelin, conforme comando abaixo:

```
kubectl create namespace kubedata-zeppelin

```

Execute  o deployment, executando os comandos abaixo:

```
kubectl apply -n kubedata-zeppelin -f zeppelin-cfg.yaml
kubectl apply -n kubedata-zeppelin  -f zeppelin-server.yaml
```

Após o término do deployment, acesse a interface do Apache Zeppelin pela url  https://zeppelin-bigdata.app.sema.df.gov.br


## Segurança

Todo acesso ao Zeppelin é feito mediante configuração de grupos LDAP. Para utilizar o Zeppelin, cadastre um usuario no LDAP (https://openldap-ui-bigdata.app.sema.df.gov.br/)
e adicione o mesmo em um dos seguintes grupos:

* ZeppelinAdmin - Usuarios administradores do Zeppelin(acesso a todas as funcionalidades)
* ZeppelinUsers - Analistas que poderão construir notebooks no Zeppelin.


Interpretador Conf

Per user/isolate
User impersonate


spark.jars	/spark/jars/hadoop-aws-3.2.0.jar,/spark/jars/aws-java-sdk-bundle-1.11.375.jar
spark.hadoop.fs.s3a.endpoint :  minio-svc.kubedata-minio.svc.cluster.local:9000
spark.hadoop.fs.s3a.connection.ssl.enabled: false
spark.hadoop.fs.s3a.path.style.access: true
spark.hadoop.fs.s3a.impl : org.apache.hadoop.fs.s3a.S3AFileSystem






## Persistencia de Dados e configurações 

Para fins de persistência dos dados do NiFi, temos  os seguintes volumes:


| Nome | Ponto de Montagem | Tamanho Mínino | Descrição | 
|---|---|---|---| 
| zeppelin-conf | /opt/zeppelin/conf | 1 Gb | Local onde as configurações do zeppelin serão persistidas. | 

Recomenda-se a realização de backups periódicos e/ou antes de atualizações/mudanças neste serviço.
