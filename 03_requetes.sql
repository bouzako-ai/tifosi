-- Projet : tifosi
-- Objet : Vérification de la base de données

USE tifosi;

-- Requete 1 : Afficher la liste des noms des focaccias par ordre alphabétique croissant
SELECT NOM FROM focaccia ORDER BY nom ASC;
-- Résultat obtenu : Focaccias triées par noms, en ordre croissant ( de A à Z)

-- Requete 2 : Afficher le nombre total d'ingrédients
SELECT COUNT(*) FROM ingredient;
-- Résultat obtenu : 25 ingrédients

-- Requete 3 : Afficher le prix moyen des focaccias
SELECT AVG(prix) FROM focaccia;
-- Résultat obtenu : 10.375000


-- Requete 4 : Afficher la liste des boissons avec leur marque, triéé par nom de boisson
SELECT boisson.nom AS boisson, marque.nom AS marque FROM boisson
JOIN marque ON boisson.id_marque = marque.id_marque
ORDER BY boisson.nom; 
-- Résultat obtenu : les 12 boissons et leur marque

-- Requete 5 : Afficher la liste des ingrédients pour une Raclaccia
SELECT ingredient.nom FROM focaccia
JOIN comprend ON focaccia.id_focaccia = comprend.id_focaccia
JOIN ingredient ON comprend.id_ingredient = ingredient.id_ingredient
WHERE focaccia.nom = 'Raclaccia';
-- Résultat obtenu : 7 lignes donc 7 ingrédients

-- Requete 6 : Afficher le nom et le nombre d'ingrédients pour chaque focaccia
SELECT focaccia.nom, COUNT(*) FROM focaccia
JOIN comprend ON focaccia.id_focaccia = comprend.id_focaccia
GROUP BY focaccia.nom;
-- Résultat obtenu : 8 lignes comprenant le nom et le nombre d'ingrédients

-- Requete 7 : Afficher le nom de la focaccia qui a le plus d'ingrédients
SELECT focaccia.nom, COUNT(*) FROM focaccia
JOIN comprend ON focaccia.id_focaccia = comprend.id_focaccia
GROUP BY focaccia.nom
ORDER BY COUNT(*) DESC -- Ordre décroissant
LIMIT 1;
-- Résultat obtenu : Paysanne = 12
-- LIMIT 1 pour ne pas afficher d'autres lignes

-- Requete 8 : Afficher la liste des focaccias qui contiennent de l'ail
SELECT focaccia.nom FROM focaccia
JOIN comprend ON focaccia.id_focaccia = comprend.id_focaccia
JOIN ingredient on comprend.id_ingredient = ingredient.id_ingredient
WHERE ingredient.nom = 'AIL';
-- Résultat obtenu : 4 focaccias ( mozaccia, gorgonzollaccia, raclaccia, paysanne)

-- Requete 9 : Afficher la liste des ingrédients inutilisés
SELECT nom FROM ingredient
WHERE id_ingredient NOT IN (SELECT id_ingredient FROM comprend);
-- Résultat obtenu : Salami et Tomate cerise

-- Requete 10 : Afficher la liste des focaccias qui n'ont pas de champignons
SELECT nom FROM focaccia WHERE id_focaccia NOT IN (
    SELECT comprend.id_focaccia FROM comprend
    JOIN ingredient ON comprend.id_ingredient = ingredient.id_ingredient
    WHERE ingredient.nom = 'Champignon'
); 
-- Résultat obtenu : 2 focaccias : Américaine et Hawaienne
-- On prend les focaccias qui ont du champignon entre
-- parenthèses et on exclut les autres avec NOT IN (américaine et hawaienne) 
 

