# L'architecture MVC

Ce repo est un exemple de programme réalisé avec l'architecture **MVC**
ou **Model View Controller**, qui est un style d'organisation utilisé
fréquemment dans le milieu du développement. Elle permet 
de savoir où aller chercher tel ou tel type de classe rapidement.

## Organisation

Il y a trois composantes principales :

- Le Model (gère l'accès à la base de données)
- La View (gère les interactions avec l'utilisateur)
- Le Controller (chef d'orchestre)

![Schéma de l'organisation habituelle](https://i.imgur.com/411m4Ch.png)

## Fonctionnement

#### 1. Le Routeur

Il **route** l'utilisateur vers le bon endroit. Par exemple si un utilisateur
veut se rendre sur la page `facebook.com/mes_messages`, le routeur redirige sa requête
vers le controller qui s'occupe des messages. Si l'utilisateur avait voulu se rendre sur
`facebook.com/mon_profil`, le routeur aurait dirigé sa requête vers le controller des
profils.

D'autre part, sachant que le routeur va pourvoir recevoir plusieurs urls différentes
qui sont censées mener vers le même controller, il faudra qu'il soit spécifique
et qu'il oriente directement sur une méthode précise du controller en question.

#### 2. Le Controller

En allant sur `facebook.com/mes_messages`, l'utilisateur va s'attendre à voir s'afficher
tous ses messages. Donc le routeur va orienter notre requête vers la méthode 
`show_messages` du controller. Celle-ci aura deux rôles qui résument bien la raison
d'être d'un controller :

1. Récupérer des informations de la base de donnée qu'il faut afficher (liste des messages, titres, expéditeur, destinataire, date de réception, ...). Pour cela, il fera
une demande au **Model** qui doit interagir avec la base de données.

2. Une fois qu'il a récupéré les infos, le controller les envoie à la **view** qui
correspond à `show_messages`. Et ce qui sera renvoyé à l'utilisateur sera une belle page
HTML mise en forme par la view.

#### 3. Le Model

C'est une autre classe qui va donc récupérer les infos dans la base de données à la
demande du controller. Ces infos sont récupérées sous la forme d'objets. Pour la page
`facebook.com/mes_messages`, le controller va demander au model de ne récupérer dans la
liste de tous les messages, que ceux qui sont dans la boite de réception de l'utilisateur.
Le model va donc aller piocher dans la base de données tous les objets de la classe
`Message`, en fonction de ses variables d'instance (texte, titre, expéditeur,
date d'envoi, ...)

Le model peut aussi servir à créer des entrées dans la base de données. Grace à une
requête SQL. Une fois que cette opération est effectuée par le model, c'est le controller
qui reprend la main.

Donc dans notre exemple avec la page `facebook.com/mes_messages`, le model va renvoyer
au controller un array `@messages` qui contient tous les objets de la classe `Message`
à afficher dans la boite de réception.

#### 4. La View

Quand le controller a toutes les informations qu'il veut, il les envoie à la **View** qui
va se charger de les afficher à l'utilisateur. Pour cela elle va devoir construire un
**fichier HTML** avec toutes les infos envoyées par le controller. C'est ce qui est
affiché sur le navigateur. Donc pour notre exemple, la view n'a plus qu'à itérer sur
notre array `@messages` en faisant `@message.each do` et pour chaque message de la boite
de réception de l'utilisateur elle pourra afficher une ligne.

Le controller peut aussi rendre plusieurs objets disponibles à la view, si on veut
afficher le nom de l'utilisateur courant, on peut le faire grace à un objet
`@current_user` de la classe `User` qui correspond à l'utilisateur actuellement connecté. La view peut afficher facilement `@current_user.name` qui renvoie le nom
et donc d'afficher quelque chose comme `Voici ta boite de réception Félix !`

Et maintenant que la page HTML est affichée, plus qu'à attendre une autre requête.

## Règles de base

- La MVC a une règle "Fat models, skinny controllers" qui veut que l'on mette le minimum
de code possible dans le controller, quitte à tout mettre dans les models.

- Les controllers seront remplis de méthodes il faut que maximum que celles-ci
correspondent à l'accronyme **CRUD** (Create, Read, Update, Destroy) et éviter d'en
rajouter d'autres, même si on doit créer plus de controllers.

- Le code doit être **DRY** (Don't Repeat Yourself) on ne doit pas écrire deux fois la
même chose. Du moins pas plus de deux fois. Si c'est le cas, le morceau de code répété
doit être mis dans une méthode et appelé en une seule ligne.

- Le DRY est primordial pour les views, (un fichier header en HTML pouvant être appelé
en une seule ligne est pratique).

- Une base de données propre est cruciale pour le bon fonctionnement de l'application web
la construction des models peut prendre du temps comparé au reste. Si ils sont baclés,
ce sont de gros problèmes en perspective.

#### Exemple

Voici un [repo github d'une application de TODO list](https://github.com/mindplace/accountability-list) qui utilise le modèle MVC.
