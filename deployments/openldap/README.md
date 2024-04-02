



# OpenLDAP

OpenLDAP é uma suíte de aplicativos LDAP open-source, que inclui todas as ferramentas necessárias para fornecer um serviço de diretório LDAP em um ambiente de rede (clientes, servidores, utilitários e ferramentas de desenvolvimento), disponível para várias plataformas (Linux, Solaris, MacOS). É uma solução considerada madura hoje em dia e possui amplo suporte, sendo largamente utilizada como alternativa às implementações comerciais existentes (Microsoft Active Directory, Novell eDirectory, Sun Java System Directory Server, etc.).


Este documento apresenta proposta de  deployment do componente OpenLDAP para a plataforma de Big Data SEMA-DF. Este componente será nosso repositorio de usuários e grupos que servirão aos sistemas de autenticação e autorização das outras ferramentas.

## Instalação

### Pré-requisitos

* Git instalado
* kubectl instalado 

### Procedimento

Faça um clone deste repositório. Vá para a pasta ``deployments/openldap`` e execute os seguintes passos:


Crie namespace para abrigar a aplicação  OpenLDAP, conforme comando abaixo:

```
kubectl create namespace kubedata-openldap

```

Execute  o deployment, executando os comandos abaixo:

```
kubectl apply -n kubedata-openldap  -f ldap-ui.-deployment.yaml
kubectl apply -n kubedata-openldap -f openldap-deployment.yaml
```

Após a conclusão do Deployment será necessário adicionar objeto memberof e criar estrutura inicial e usuarios e grupos para os serviços do cluster. Para isto será necessario abrir uma sessão shell no pod  
openldap-deployment-xxxxxx e executar os seguintes comandos: 

```

ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /bitnami/openldap/memberof.ldif

ldapadd -x -H ldap://openldap-svc:389 -D cn=admin,dc=poc,dc=br -W -f /bitnami/openldap/inittree.ldif

ldapadd -x -H ldap://openldap-svc:389 -D cn=admin,dc=poc,dc=br -W -f /bitnami/openldap/nifi.ldif

ldapadd -x -H ldap://openldap-svc:389 -D cn=admin,dc=poc,dc=br -W -f /bitnami/openldap/airflow.ldif

ldapadd -x -H ldap://openldap-svc:389 -D cn=admin,dc=poc,dc=br -W -f /bitnami/openldap/trino.ldif

ldapadd -x -H ldap://openldap-svc:389 -D cn=admin,dc=poc,dc=br -W -f /bitnami/openldap/superset.ldif

ldapadd -x -H ldap://openldap-svc:389 -D cn=admin,dc=poc,dc=br -W -f /bitnami/openldap/zeppelin.ldif

ldapadd -x -H ldap://openldap-svc:389 -D cn=admin,dc=poc,dc=br -W -f /bitnami/openldap/ranger.ldif

ldapadd -x -H ldap://openldap-svc:389 -D cn=admin,dc=poc,dc=br -W -f /bitnami/openldap/jupyterhub.ldif

```
Após isto , altere as senhas dos usuários `<sistema>.admin` 


Você pode fazer isto através da  interface do OpenLDAP (https://openldap-ui--bigdata.app.sema.df.gov.br/)


## Segurança

O Acesso a ferramenta de administração é feita com o usuario `cn=admin,dc=poc,dc=br`.


## Persistencia de Dados e configurações 

Para fins de persistência dos dados do OpenLDAP, temos  os seguintes volumes:


| Nome | Ponto de Montagem | Tamanho Mínino | Descrição | 
|---|---|---|---| 
| ldap-data-pvc | /bitnami/openldap | 1 Gb | Local onde os dados do LDAP são armazenados. |  


Recomenda-se a realização de backups periódicos e/ou antes de atualizações/mudanças neste serviço.



## Referências

* http://adminstuffs.blogspot.com/2017/01/creating-users-and-groups-in-openldap.html

