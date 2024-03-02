--1
SELECT * FROM client 
WHERE LENGTH(nomc) > 5;

--2
SELECT SUBSTR (nomc,1,3) FROM client

--3
SELECT * FROM produit
WHERE SUBSTR(lib, 3, 1) = 'a'
   OR SUBSTR(lib, 4, 1) = 'a'
   OR SUBSTR(lib, 7, 1) = 'a';

--4
SELECT 
    CONCAT(
        '###',
        RPAD(adressec,LENGTH(adressec) +3, '*')
    ) 
FROM client;

--5
SELECT TRIM(' 'FROM adressec) FROM client

--6
SELECT INITCAP(adressec) FROM client

--7
SELECT * FROM client
WHERE LOWER(adressec) = 'tunis'

--8
SELECT SUBSTR(lib, 2, 1), ASCII(SUBSTR(lib, 2, 1))
FROM produit;

--PARIE IV
--1
SELECT NULLIF(adressec, 'CLient sans adresse !')
FROM client;

--2
SELECT NULLIF(LENGTH(nomc), LENGTH(adressec))
FROM client;

--PARTIE V
--1
SELECT CURRENT_DATE+1 from dual

--2
SELECT CURRENT_DATE+7 from dual

--3
SELECT LAST_DAY(CURRENT_DATE) from dual

--4
SELECT ADD_MONTHS(CURRENT_DATE,4) FROM dual

--5
SELECT MONTHS_BETWEEN(CURRENT_DATE+65,CURRENT_DATE) FROM dual

--6
SELECT TO_CHAR(CURRENT_DATE, 'YYYY') FROM dual;

--PARTIE VI
--1
SELECT TO_CHAR(CURRENT_DATE, 'DD MONTH YYYY') FROM dual;

--2
SELECT TO_CHAR(CURRENT_DATE, 'DD/MM/YYYY HH24:MI:SS') FROM dual;

--3
SELECT CURRENT_DATE - to_date('18/05/2002','DD/MM/YYYY') FROM dual

--4
SELECT MONTHS_BETWEEN(CURRENT_DATE,'18/MAY/2002') FROM dual;

--5
SELECT TO_CHAR(DATE '2002-05-18', 'DAY') FROM DUAL;

--6

SELECT * FROM Commande WHERE DATC BETWEEN TO_DATE('2000-01-01', 'YYYY-MM-DD') AND TO_DATE('2010-12-31', 'YYYY-MM-DD');

--7

SELECT NVL(TO_CHAR(MontF), 'Montant vide')
FROM Facture;



