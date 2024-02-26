--tp1
--Partie 1
--1
create table Client(
    Code number(4) PRIMARY KEY,
    Nomc varchar(20),
    Ville varchar(20)
);

create table Commande(
    Numc number(4),
    Datec date,
    Mnte number(10,3),
    Code number(4), --faut de frappe en Codc
    constraint pk_Numc PRIMARY KEY  (Numc)
);

create table Produit(
    RefP varchar(6),
    Libp varchar(20),
    PU number(10,3),
    Qtes number(4),
    Seuil number(4),
    constraint pk_RefP PRIMARY KEY  (RefP)
);

create table Lig_Cde(
   Numc number(4),
   Refp varchar(6),
   Qtec number(4),
    constraint pk_Numc_RefP PRIMARY KEY  (Numc, Refp)
);

create table Frs_Prod(
   Codf number(4),
   RefP varchar(6),
   PUf number(10,3),
   Qtef number(4),
    constraint pk_Codf_RefP PRIMARY KEY  (Codf, RefP)
);

--2
alter table Client
add constraint fk_code FOREIGN KEY  (Code) references Client(Code) NOT NULL;

--3
alter table Lig_Cde
add CONSTRAINT fk_Numc FOREIGN KEY (Numc) REFERENCES Commande(Numc),
add CONSTRAINT fk_RefP FOREIGN KEY (RefP) REFERENCES Produit(RefP);

--4
alter table Frs_Prod
add constraint fk_codf FOREIGN KEY (Codf)  references Fournisseur(Codf),
add constraint fk_RefP FOREIGN KEY (RefP)  references Produit(RefP);

--5
alter table Client
add CA number(10,3),
add Cred number(10,3),
add CredMax number(10,3);

--6
alter table Client
modify Ville varchar(10);

--7
alter table Client
add constraint ck_Cred check (Cred <= CredMax);

--8
alter table Produit
add constraint ck_Qtes check (Qtes > 0 ),
add constraint ck_Seuil check (Seuil > 0 );

alter table Lig_Cde
add constraint ck_Qtec check (Qtec > 0 );

alter table Frs_Prod
add constraint ck_Qtef check (Qtef > 0 );

--9
create index i_Nomc on Client(Nomc);

--10
create index i_Libp on Produit(Libp);

--11
create index i_Nomf on Fournisseur(Nomf);

--12
INSERT INTO Client(Code, Nomc, Ville) VALUES (100, 'STS', 'Sousse');
INSERT INTO Client(Code, Nomc, Ville) VALUES (200, 'STIP', 'Sousse');
INSERT INTO Client(Code, Nomc, Ville) VALUES (300, 'AMS', 'Monastir');
INSERT INTO Client(Code, Nomc, Ville) VALUES (400, 'TOTAL', 'Sousse');
INSERT INTO Client(Code, Nomc, Ville) VALUES (500, 'METS', 'Bizerte');
INSERT INTO Client(Code, Nomc, Ville) VALUES (600, 'TOUTA', 'Bizerte');
INSERT INTO Client(Code, Nomc, Ville) VALUES (700, 'STB', 'Sousse');
INSERT INTO Client(Code, Nomc, Ville) VALUES (800, 'Comar', 'Tunis');
INSERT INTO Client(Code, Nomc, Ville) VALUES (900, 'INFOPLUS', 'Tunis');
INSERT INTO Client(Code, Nomc, Ville) VALUES (1000, 'BIAT', 'Tunis');

INSERT INTO Commande(Numc, Datec, Code) VALUES (10, to_date('02/01/2010','DD/MM/YYYY'), 100);
INSERT INTO Commande(Numc, Datec, Code) VALUES (20, to_date('02/01/2010','DD/MM/YYYY') ,200);
INSERT INTO Commande(Numc, Datec, Code) VALUES (30, to_date('04/01/2010','DD/MM/YYYY'), 100);
INSERT INTO Commande(Numc, Datec, Code) VALUES (40, to_date('15/01/2010','DD/MM/YYYY'), 300);
INSERT INTO Commande(Numc, Datec, Code) VALUES (50, to_date('15/01/2010','DD/MM/YYYY'), 100);
INSERT INTO Commande(Numc, Datec, Code) VALUES (60, to_date('23/01/2010','DD/MM/YYYY'), 500);
INSERT INTO Commande(Numc, Datec, Code) VALUES (70, to_date('01/01/2010','DD/MM/YYYY'), 600);
INSERT INTO Commande(Numc, Datec, Code) VALUES (80, to_date('05/01/2010','DD/MM/YYYY'), 300);
INSERT INTO Commande(Numc, Datec, Code) VALUES (90, to_date('10/02/2010','DD/MM/YYYY'), 500);

--13
--script lancé

--14
update Client
set CA=0, Cred=0, CredMax=1000;

--15
update Commande
set Mnte=0;

--16
update Produit
set Seuil = Qtes*0.1;

--17
create view V_ClientSousse as 
select  * from Client where Ville='Sousse';

--18
insert into V_ClientSousse (Code, Nomc, Ville, CA, Cred, CredMax ) VALUES (1111, 'Randa', 'Tunis', 0, 0,1000);

--19
insert into V_ClientSousse (Code, Nomc, Ville, CA, Cred, CredMax ) VALUES (2222, 'Epi dOr', 'Sousse', 0, 0,1000);

--20
create view V_FrsReel AS
select distinct Fournisseur.Codf, Fournisseur.Nomf
from Fournisseur
join Frs_Prod ON Fournisseur.Codf = Frs_Prod.Codf;

--Partie 2
--21
select * from produit;

--22
select * from produit where PU <=100;

--23
select Numc, Code from Commande where Datec > to_date('31/01/2010','DD/MM/YYYY');

--24
-- Your SQL query or action here

--25
select * from client where Ville != 'Tunis' and Cred > CredMax;

--26
select * from produit where PU > 250 order by PU asc;

--27
select count(Code) from commande
where Datec between to_date('01/01/2010','DD/MM/YYYY') and to_date('31/01/2010','DD/MM/YYYY');

--28
select SUM(Qtec) AS TotP
from Lig_cde
where RefP = 'BU44';

--29
SELECT Code, Nomc, Ville, CA
FROM Client
WHERE CA > (SELECT AVG(CA) FROM Client);

--30
SELECT *
FROM Produit
WHERE PU = (SELECT MAX(PU) FROM Produit);

--31
SELECT Produit.Libp, Produit.PU
FROM Commande
JOIN Lig_Cde ON Commande.Numc = Lig_Cde.Numc
JOIN Produit ON Lig_Cde.RefP = Produit.RefP
WHERE Commande.Numc = 70
ORDER BY Produit.Libp;

--32
SELECT Client.Code, Client.Nomc, Client.Ville, SUM(Commande.Mnte) AS CA
FROM Client
JOIN Commande ON Client.Code = Commande.Code
GROUP BY Client.Code, Client.Nomc, Client.Ville
ORDER BY CA DESC;

--33
SELECT *
FROM Produit
WHERE PU > (SELECT PU FROM Produit WHERE RefP = 'MI33');

--34
SELECT Codf, SUM(Qtef) AS TotalQuantities
FROM Frs_Prod
GROUP BY Codf;

--35
SELECT Produit.RefP, Produit.Libp, Produit.PU, Lig_Cde.Qtec, Commande.Numc, Commande.Datec, Client.Code AS Codc, Client.Nomc
FROM Commande
JOIN Client ON Commande.Code = Client.Code
JOIN Lig_Cde ON Commande.Numc = Lig_Cde.Numc
JOIN Produit ON Lig_Cde.RefP = Produit.RefP
WHERE Client.Ville = 'Sousse';

--36
SELECT Commande.Code, Client.Nomc, COUNT(Commande.Numc) AS NumOrders
FROM Commande
JOIN Client ON Commande.Code = Client.Code
GROUP BY Commande.Code, Client.Nomc;

--37
SELECT Numc, COUNT(Refp) AS NumProducts
FROM Lig_Cde
GROUP BY Numc;

--38
SELECT Produit.*
FROM Produit
LEFT JOIN Lig_Cde ON Produit.RefP = Lig_Cde.RefP
WHERE Lig_Cde.RefP IS NULL;

--39
select Codf, Nomf
from Fournisseur
join Frs_Prod ON Fournisseur.Codf = Frs_Prod.Codf
join Lig_Cde ON Frs_Prod.RefP = Lig_Cde.RefP
join Commande ON Lig_Cde.Numc = Commande.Numc
join Client ON Commande.Code = Client.Code
where Client.Ville = 'Tunis';

--40
SELECT RefP, COUNT(Codf) AS NumSuppliers
FROM Frs_Prod
GROUP BY RefP;

--41
SELECT DISTINCT Client.Code, Client.Nomc
FROM Lig_Cde
JOIN Commande ON Lig_Cde.Numc = Commande.Numc
JOIN Client ON Commande.Code = Client.Code
WHERE Lig_Cde.Numc IN (SELECT Numc FROM Lig_Cde WHERE RefP IN (SELECT RefP FROM Lig_Cde WHERE Numc = 100));

--42
SELECT Numc, Datec, COUNT(RefP) AS Nbrp
FROM Lig_Cde
GROUP BY Numc, Datec
ORDER BY COUNT(RefP) DESC
FETCH FIRST ROW ONLY;

--43
SELECT Numc, Datec, SUM(Mnte) AS Totalc
FROM Commande
GROUP BY Numc, Datec
ORDER BY SUM(Mnte) DESC
FETCH FIRST ROW ONLY;

--44
SELECT Client.Code AS Codc, Client.Nomc, COUNT(Commande.Numc) AS Nbc, SUM(Commande.Mnte) AS Totc
FROM Client
JOIN Commande ON Client.Code = Commande.Code
GROUP BY Client.Code, Client.Nomc
HAVING COUNT(Commande.Numc) >= 3;

--45
SELECT Client.Code AS Codc, Client.Nomc, Client.Ville
FROM Client
JOIN Commande ON Client.Code = Commande.Code
GROUP BY Client.Code, Client.Nomc, Client.Ville
HAVING COUNT(DISTINCT Commande.Numc) = (SELECT COUNT(DISTINCT RefP) FROM Produit);

--46
SELECT RefP, Libp
FROM Produit
WHERE NOT EXISTS (
    SELECT DISTINCT Code
    FROM Client
    WHERE NOT EXISTS (
        SELECT *
        FROM Commande
        JOIN Lig_Cde ON Commande.Numc = Lig_Cde.Numc
        WHERE Client.Code = Commande.Code AND Lig_Cde.RefP = Produit.RefP
    )
);

--47
SELECT DISTINCT Fournisseur.Codf, Fournisseur.Nomf
FROM Fournisseur
JOIN Frs_Prod ON Fournisseur.Codf = Frs_Prod.Codf
WHERE Frs_Prod.RefP NOT IN (
    SELECT DISTINCT RefP
    FROM Lig_Cde
    JOIN Commande ON Lig_Cde.Numc = Commande.Numc
    JOIN Client ON Commande.Code = Client.Code
    WHERE Client.Ville = 'Sousse'
);

--48
SELECT RefP, Libp, PU
FROM Produit
WHERE RefP IN (
    SELECT RefP
    FROM Frs_Prod
    GROUP BY RefP
    HAVING COUNT(DISTINCT Codf) > 1
);

--49
SELECT RefP, AVG(PU) AS AvgPriceSupplier
FROM Produit
GROUP BY RefP;
