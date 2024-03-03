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
