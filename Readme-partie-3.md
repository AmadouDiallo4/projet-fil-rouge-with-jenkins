## PARTIE 3: Déploiement des différentes applications dans un cluster Kubernetes

## a. Architecture
L'entreprise souhaites à présent migrer ses applications sur cluster ``Kubernetes``, car semblerait -il que cette solution d'orchestration offre plus de possibilités que la solution native de docker, ``docker SWARM``. On se propose donc de donner une amélioration du Pipeline intégrant celà. Les applications pourront être déployées dans le cluster, selon l'architecture suivante:
![](images/synoptique_Kubernetes.jpeg)

Etant donné cette architecture logicielle, bien vouloir identifier en donnant le type et le rôle de chacune des ressources (A…H) mentionnées. 

L’ensemble de ces ressources devront être crées dans un namespace particulier appelé ``icgroup`` et devront obligatoirement avoir au moins le label ``env = prod``

## b. Identification des Ressources

### b.1 - Ressource A
La ressource en `A` est un Service de type `NodePort`, ce service va exposer à l'extérieur la ressource `B` `ic-webapp` à travers l'adresse IP de l'hôte et du port `30080` sous la forme `ip_instance:30080`.

>NB: les ports des services de type `NodePort` sont normalement attribués dynamiquement et compris entre `30000-32768`.

### b.2 - Ressource B 
La ressource `B` est un `Deployment` avec 2 Pods, il permet le déploiement de l'application `ic-webapp`.

### b.3 - Ressource C

La ressource `C` est un service de type `NodePort` qui va exposer la ressource `D` `odoo` sur le port `30069` sous la forme `ip_instance:30069`


### b.4 - Ressource D

La ressource `D` est un `Deployment` avec 2 pods , il permet le déploiement de l'application `odoo`

### b.5 - Ressource E 
La ressource `E` est un service de type `ClusterIP` qui va exposer la ressource `F` `Postgres` 
>***ClusterIP:*** *Expose le service sur une IP interne du cluster contrairement au NodePort qui expose via l'IP de l'hôte.*

### b.6 - Ressource F

La ressource `F` est une ressource de type `StatefulSet` avec un replicas de 01 `Pod` il permet le déploiement de la Base de données `Postgres`

>*à la différence du `Deployment` le `StatefulSet` est utilisé pour les applications à `état (stateful)` qui necéssite un stockage permenant des données.*

### b.7 - Ressource G

La ressource en `G` est un service de type `NodePort` qui va exposer la ressource `H` `(pgadmin)` sur le port `30200`

### b.8 - Ressource H

La ressource en `H` est un `Deployment` avec un replicas de 01 `Pod` , il permet le déploiement de l'application `Pgadmin`

>NB: Les ports à ouvrir dans la sécurity group `sg` seront modifiés pour être adapter aux des services de type `NodePort`:
- `8080` -> `30080` : `ic-webapp`
- `8081` -> `30200` : `pgadmin`
- `8069` -> `30069` : `odoo`