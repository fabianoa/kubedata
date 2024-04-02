
# Apache NiFi - Single Instance

O Apache NiFi é um projeto de código aberto da Apache Software Foundation que fornece uma plataforma para automatizar o fluxo de dados entre sistemas diversos. Ele é projetado para facilitar a movimentação e o processamento de dados em tempo real, com ênfase em fluxos de dados em larga escala, confiabilidade e extensibilidade.

Este documento apresenta proposta de  deployment de componente Apache NiFi single Intance para a plataforma de Big Data SEMA-DF.

## Instalação

### Pré-requisitos

* Git instalado
* kubectl instalado 

### Procedimento

Faça um clone deste repositório. Vá para a pasta ``deployments/nifi`` e execute os seguintes passos:


Crie namespace para abrigar a aplicação  Nifi, conforme comando abaixo:

```
kubectl create namespace nifi-bigdata

```

Execute  o deployment, executando os comandos abaixo:

```
kubectl apply -n nifi-bigdata  -f nifi-config.yaml
kubectl apply -n nifi-bigdata  -f nifi-single-instance.yaml
```

Após o término do deployment, acesse a interface do Nifi pela url  https://nifi-bigdata.app.sema.df.gov.br/nifi/


## Segurança

Todo acesso ao Nifi é feito mediante configuração de grupos LDAP. Para utilizar o Nifi, cadastre um usuario no LDAP (https://openldap-ui-bigdata.app.sema.df.gov.br/)
e adicione o mesmo em um dos seguintes grupos:

* NifiAdmin - Usuarios administradores do Nifi (acesso a todas as funcionalidades)
* NifiUsers - Usuarios comuns que podem apenas visualizar os dataflows.

Caso se tenha a necessidade de criar um novo perfil de usuario , será necessário criar um grupo na OU  ``Nifi,ou=Groups,dc=sema,dc=df,dc=gov,dc=br`` e associar a um conjunto de policies no Nifi.



## Persistencia de Dados e configurações 

Para fins de persistência dos dados do NiFi, temos  os seguintes volumes:


| Nome | Ponto de Montagem | Tamanho Mínino | Descrição | 
|---|---|---|---| 
| nifi-content-repository | /opt/nifi/nifi-current/flow-repository | 20 Gb | Local onde o conteúdo do flow é armazenado, até que o mesmo seja processado. |  
| nifi-flowfile-repository | /opt/nifi/nifi-current/flowfile_repository | 20 Gb | Local onde o conrole do estado do flow é armazenado. | 
| nifi-flow-repository | /opt/nifi/nifi-current/flow-repository | 1 Gb | Local onde os flowfile (código) são aramendados. Ver propriedade nifi.flow.configuration.file | 
| nifi-provenance-repository | /opt/nifi/nifi-current/provenance_repository | 20 Gb | Local onde o conrole do estado do flow é armazenado. | 
| nifi-zona-transicao | /dados/zona_transicao | 100 Gb | Local onde arquivos de entrada e saída são armazenados. | 

Recomenda-se a realização de backups periódicos e/ou antes de atualizações/mudanças neste serviço.

## Referências

* https://medium.com/rescuepoint/apache-nifi-standalone-com-tls-ssl-e-openldap-db0284cd0ec3