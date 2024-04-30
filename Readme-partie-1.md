# PARTIE 1: Conteneurisation de l’application web
Voici les étapes à suivre pour la conteneurisation de cette application:

1) L'image de base sera ```python:3.6-alpine```
2) Définir le répertoire `/opt` comme répertoire de travail 
3) Installer le module Flask version 1.1.2 à l’aide de `pip install flask==1.1.2`
4) Exposer le port `8080` qui est celui utilisé par défaut par l'application
5) Créer les variables d’environnement `ODOO_URL` et `PGADMIN_URL` afin de permettre la définition des url applicatives lors du lancement du conteneur
6) Lancer l’application `app.py` dans le `ENTRYPOINT` grâce à la commande `python`

Une fois le Dockerfile crée, buildez l'image et lancer un conteneur de test permettant d’aller sur les sites web officiels de chacune de ces applications ( les sites web officiels sont fournis ci-dessus). 

### Nom de l'artefact et registre utilisé
Une fois le test terminé, supprimez le conteneur de test et poussez votre image sur votre registre Docker hub. L'image finale devra se nommer comme suit:

- **Nom:**  ``ic-webapp``   
- **Tag:** ``1.0``  
- **Nom du conteneur de test:** ``test-ic-webapp``

### a. Création du Projet fil rouge
Nous allons commencer par la création du Projet sur **github.com** pour ensuite le cloner localement.
Pour cela il faut suivre ces étapes: **repositories** -> **New** -> **Repository name** et renseigner les informations demandées.


![](images/github.png)
---
- clonage du projet en local
```
$ git clone https://github.com/gbaneassouman/projet-fil-rouge-with-jenkins.git
```
```
$ cd projet-fil-rouge-with-jenkins && mkdir -p src
```
Le dossier `src` est le dossier qui va contenir l'ensemble des codes

### b. Écriture du Dockerfile 
- Création du Dockerfile
```
projet-fil-rouge-with-jenkins$ touch src/Dockerfile 
```

```
FROM python:3.6-alpine
LABEL maintener="GBANE Assouman"
LABEL email="gbane.assouman@gmail.com"
WORKDIR /opt
RUN pip install flask==1.1.2
COPY ./app/ /opt/
EXPOSE 8080
ENV ODOO_URL='https://www.odoo.com/'
ENV PGADMIN_URL='https://www.pgadmin.org/'
ENTRYPOINT ["python","app.py"]
```
*NB: Le code source a été rassemblé dans le dossier **app***
### c. Build et Test

- Build
```
$ docker build -t ic-webapp:1.0 .

```
```
$ docker run --name test-ic-webapp -d -p 4444:8080 ic-webapp:1.0 
2033634663fe21cfa71557b2b16a2dd5efc8828e5cbe1adfede40cc78fd9927c
```
```
$ docker ps -a|grep -i "test-ic-webapp"
2033634663fe   ic-webapp:1.0                       "python app.py"          12 seconds ago      Up 11 seconds                   0.0.0.0:4444->8080/tcp, :::4444->8080/tcp              test-ic-webapp
```
- Test 

![](images/test-ic-webapp.png)
---

### d. Push vers Dockerhub
- Procédons d'abord à l'arrêt puis à la supression du conteneur
```
$ docker stop test-ic-webapp 
test-ic-webap
```
```
$ docker rm test-ic-webapp 
test-ic-webapp
```
```
$ docker tag ic-webapp:1.0 openlab89/ic-webapp:1.0
```
```
$ docker push openlab89/ic-webapp:1.0 
The push refers to repository [docker.io/openlab89/ic-webapp]
cb85cd2e3be1: Pushed 
81c97900e352: Pushed 
3156423bd38f: Mounted from library/python 
efa76becf38b: Mounted from library/python 
671e3248113c: Mounted from library/python 
1965cfbef2ab: Mounted from library/python 
8d3ac3489996: Mounted from library/python 
1.0: digest: sha256:b18bc5973a28538507f2cdc494f0e15ec905faed6f4ea672c54f33b5acfc22f9 size: 1789
```
- **Résultat**

![](images/hub.png)
---