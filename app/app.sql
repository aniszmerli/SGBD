--1
DECLARE
    num Ligne.numligne%TYPE;
BEGIN
    num := &numligne;

    FOR c IN (SELECT * FROM Ligne WHERE numligne = num) LOOP
        DBMS_OUTPUT.PUT_LINE('Numero de ligne: ' || c.numligne);
        DBMS_OUTPUT.PUT_LINE('Date de chargement: ' || c.datechargement);
        DBMS_OUTPUT.PUT_LINE('Montant disponible: ' || c.montantdisponible);
        DBMS_OUTPUT.PUT_LINE('etat: ' || c.etat);
        DBMS_OUTPUT.PUT_LINE('Date depuisement: ' || c.dateepuisement);
        DBMS_OUTPUT.PUT_LINE('ID Client: ' || c.idclient);
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Aucune ligne trouvee pour le numero de ligne saisie');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Une erreur sest produite');
END;
/

--2
DECLARE
    id client.idclient%TYPE;
    nom client.nomclient%TYPE;
    ville client.ville%TYPE;
BEGIN
    id := &idclient;

    SELECT nomclient, ville
    INTO nom, ville
    FROM client
    WHERE idclient = id;

    DBMS_OUTPUT.PUT_LINE('Nom du client: ' || nom);
    DBMS_OUTPUT.PUT_LINE('Ville du client: ' || ville);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Aucun client trouvé pour le numéro de client saisi');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Une erreur sest produite ' );
END;
/

--3
DECLARE
    id ligne.idclient%TYPE;
    total NUMBER := 0;
    msg VARCHAR2(50);
BEGIN
    id := &idclient;

    SELECT NVL(SUM(montantdisponible), 0)
    INTO total
    FROM ligne
    WHERE idclient = id;

    IF total = 0 THEN
        msg := 'Client sans ligne';
    ELSIF total < 5 THEN
        msg := 'Mauvais client';
    ELSIF total <= 20 THEN
        msg := 'Client moyen';
    ELSE
        msg := 'Bon client';
    END IF;

    DBMS_OUTPUT.PUT_LINE(msg);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Aucun client trouvé pour le numéro de client saisi');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Une erreur sest produite ');
END;
/

--4
DECLARE
    num ligne.numligne%TYPE := 97555634;
    montant ligne.montantdisponible%TYPE;
    nv_montant ligne.montantdisponible%TYPE;
BEGIN
    SELECT montantdisponible
    INTO montant
    FROM ligne
    WHERE numligne = num;

    nv_montant := montant * 1.05;

    UPDATE ligne
    SET montantdisponible = nv_montant
    WHERE numligne = num;

    DBMS_OUTPUT.PUT_LINE('Montant disponible de la ligne ' || num || ' a ete augmenté de 5%');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Aucune ligne trouvee pour le numero de ligne ' || num ||);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Une erreur s est produite ');
END;
/

--5
DECLARE
    num ligne.numligne%TYPE;
    montant ligne.montantdisponible%TYPE;
BEGIN
    num := &num;
    montant := &montant;

    UPDATE ligne
    SET montantdisponible = montantdisponible + montant,
        datechargement = SYSDATE,
        dateepuisement = ADD_MONTHS(SYSDATE, 3)
    WHERE numligne = num;

    DBMS_OUTPUT.PUT_LINE('Recharge effectuée avec succès pour la ligne ' || num);
    DBMS_OUTPUT.PUT_LINE('Nouveau solde : ' || montant || ' (ancien solde + recharge)');
    DBMS_OUTPUT.PUT_LINE('Nouvelle date de chargement : ' || TO_CHAR(SYSDATE, 'DD/MM/YYYY'));
    DBMS_OUTPUT.PUT_LINE('Nouvelle date d''épuisement : ' || TO_CHAR(ADD_MONTHS(SYSDATE, 3), 'DD/MM/YYYY'));

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('La ligne specifiee n existe pas');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Une erreur s est produite ' );
        ROLLBACK;
END;
/

--6
DECLARE
    date_limite DATE;
BEGIN
    date_limite := ADD_MONTHS(SYSDATE, -3);

    DELETE FROM ligne
    WHERE etat = 'bloque' AND dateepuisement <= date_limite;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Une erreur s''est produite ');
        ROLLBACK;
END;
/
