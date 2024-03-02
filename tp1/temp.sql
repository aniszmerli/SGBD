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
