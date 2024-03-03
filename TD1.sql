--Exercice 1
--1
CREATE VIEW Client_Tunis AS
SELECT * FROM Client WHERE Ville = 'Tunis';
 
 --non car le client n habite pas a tunis
 --non car la vue filtre la ville pas le num de client

 --2
CREATE VIEW Nombre_Lignes_Commandes AS
SELECT NumCl, COUNT(*) AS Nombre_Lignes
FROM Ligne_Commande
GROUP BY NumCl;

--non car la vue jsute calcul le nombre de client

--3
CREATE VIEW Détails_Lignes_Commandes AS
SELECT c.NumCl, c.Nom, lc.NumPdt, p.Libellé, p.Prix, lc.DateCmd, lc.Qtite
FROM Client c
JOIN Ligne_Commande lc ON c.NumCl = lc.NumCl
JOIN Produit p ON lc.NumPdt = p.NumPdt;

 --a
 SELECT DISTINCT Nom
FROM Détails_Lignes_Commandes
WHERE NumPdt = 'pt002';

--b
SELECT DISTINCT Nom
FROM Détails_Lignes_Commandes
WHERE Prix > 100;

--c
SELECT NumPdt, Libellé
FROM Détails_Lignes_Commandes
GROUP BY NumPdt, Libellé
HAVING COUNT(*) > 2;

--d
--non car la vue est basee sur plusieurs tables ne sont pas modifiables

--e
--non il ne pas possible de faire update de cette maniere a travers une vue

--4
CREATE VIEW Totaux_Lignes_Commandes_Client AS
SELECT lc.NumCl, c.Nom, SUM(lc.Qtite * p.Prix) AS Total
FROM Ligne_Commande lc
INNER JOIN Client c ON lc.NumCl = c.NumCl
INNER JOIN Produit p ON lc.NumPdt = p.NumPdt
GROUP BY lc.NumCl, c.Nom;

--a
SELECT *
FROM Totaux_Lignes_Commandes_Client
WHERE Total > 10000;

--b
--non car le vue faire une agregation SUM

--Exercice 2
--1
CREATE VIEW Pilote_nom AS
SELECT PLNUM, PLNOM
FROM PILOTE;

--non car le prenom n'est pas inclus dans la vue

--2
CREATE VIEW Détails_Vols AS
SELECT V.VOLNUM, P.PLNOM, A.AVNOM
FROM VOL V
JOIN PILOTE P ON V.PLNUM = P.PLNUM
JOIN AVION A ON V.AVNUM = A.AVNUM;

--a
--la vue permet d'afficher les details de chaque vol

--b
--non car la vue ne permet pas les modifications sur plusieurs tables

--c
--non car la vue basee sure plusieurs table. alors elle n'est pas modifiable

--d
--non car la vue ne permet pas les modifications sur plusieurs tables

--Exercice 3
--1
CREATE USER Ali IDENTIFIED BY 123;
CREATE USER Ahmed IDENTIFIED BY 321;
CREATE USER Imane IDENTIFIED BY abc;

--2
CREATE ROLE Surveillant;
CREATE ROLE Formateur;
CREATE ROLE Directeur;

--3
GRANT INSERT, UPDATE, DELETE ON Stagiaire TO Surveillant;

GRANT INSERT, UPDATE, DELETE ON Matière TO Directeur;

GRANT INSERT, UPDATE, DELETE ON Note TO Formateur;

--4
GRANT Surveillant TO Ali;

GRANT Formateur TO Ahmed;

GRANT Directeur TO Imane;

--Exercice 4
