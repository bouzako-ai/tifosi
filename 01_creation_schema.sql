-- Projet : tifosi
-- Objet : Création de la base de donnéés, de l'utilisateur et des tables

-- Supprime la base si elle existe pour relancer le script
DROP DATABASE IF EXISTS tifosi;

-- Création base avec encodage
CREATE DATABASE tifosi
CHARACTER SET utf8mb4;

-- Création utilisateur tifosi
DROP USER IF EXISTS 'tifosi'@'localhost';
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'tifosi-2026';

-- Accorde les droits à tifosi sur la base de tifosi UNIQUEMENT
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';

-- On créér les tables en se plaçant dans la base
USE tifosi;

-- Création de la table ingrédients
CREATE TABLE ingredient ( id_ingredient INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(50) NOT NULL,
PRIMARY KEY (id_ingredient), 
UNIQUE (nom) );

-- Création de la table marque
CREATE TABLE marque ( id_marque INT NOT NULL AUTO_INCREMENT, 
nom VARCHAR(50) NOT NULL, 
PRIMARY KEY (id_marque), 
UNIQUE (nom));

-- Création de la table focaccia
CREATE TABLE focaccia ( id_focaccia INT NOT NULL AUTO_INCREMENT, 
nom VARCHAR(50) NOT NULL, 
prix DECIMAL(5,2) NOT NULL, 
PRIMARY KEY (id_focaccia), 
UNIQUE (nom) );

-- Création de la table client
CREATE TABLE client ( id_client INT NOT NULL AUTO_INCREMENT, 
nom VARCHAR(50) NOT NULL,
email VARCHAR(150) NOT NULL, 
code_postal INT NOT NULL, 
PRIMARY KEY ( id_client), 
UNIQUE (email));

-- Création de la table boisson qui appartient chacune à une marque
CREATE TABLE boisson ( id_boisson INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(50) NOT NULL,
id_marque INT NOT NULL, -- numéro de la marque de la boisson
PRIMARY KEY ( id_boisson),
UNIQUE (nom),
FOREIGN KEY (id_marque) REFERENCES marque (id_marque) -- marque doit exister
);

-- Création de la table menu
CREATE TABLE menu ( id_menu INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(50) NOT NULL,
prix DECIMAL(5,2) NOT NULL,
id_focaccia INT NOT NULL,
PRIMARY KEY ( id_menu),
UNIQUE (nom),
FOREIGN KEY (id_focaccia) REFERENCES focaccia (id_focaccia)
);

-- Table d'association "comprend" qui décrit les ingrédients de chaque focaccia 
CREATE TABLE comprend (id_focaccia   INT NOT NULL,
id_ingredient INT NOT NULL,
quantite      INT NOT NULL, -- quantité de l'ingrédient                   
PRIMARY KEY (id_focaccia, id_ingredient),      
FOREIGN KEY (id_focaccia)   REFERENCES focaccia (id_focaccia),
FOREIGN KEY (id_ingredient) REFERENCES ingredient (id_ingredient) -- existence de focaccia et ingrédient
);

-- Table d'association "contient"
CREATE TABLE contient ( id_menu INT NOT NULL,
id_boisson INT NOT NULL,
PRIMARY KEY (id_menu, id_boisson),
FOREIGN KEY (id_menu) REFERENCES menu (id_menu),
FOREIGN KEY (id_boisson) REFERENCES boisson (id_boisson) -- existence de menu et boisson
);

-- Table d'association "achete"
CREATE TABLE achete (id_client INT NOT NULL,
id_menu INT NOT NULL,
date_achat DATE NOT NULL, -- date de l'achat
PRIMARY KEY(id_client, id_menu, date_achat),
FOREIGN KEY (id_client) REFERENCES client (id_client),
FOREIGN KEY (id_menu) REFERENCES menu (id_menu)
);

