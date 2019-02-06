DELIMITER $$
DROP PROCEDURE IF EXISTS fillDate;
CREATE PROCEDURE fillDate()
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE dataTabela CHAR(254);
    DECLARE utilTabela CHAR(1);
    DECLARE feriadoTabela CHAR(1);
    DECLARE realDate DATE;
    DECLARE cur1 CURSOR FOR
		SELECT data, util, feriado FROM sakila_dsa.calendario;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur1;
    
    read_loop: LOOP
		FETCH cur1 INTO dataTabela, utilTabela, feriadoTabela;
        IF done THEN
			LEAVE read_loop;
		END IF;
        set @realDate = STR_TO_DATE(dataTabela, '%d-%m-%Y');
        INSERT INTO sakila_dw.dim_date(day, month, year, day_of_week, week_of_year, util, feriado, valor)
			VALUES (
					day(@realDate), month(@realDate), year(@realDate),
					dayofweek(@realDate), weekofyear(@realDate),
					ifnull(CAST(utilTabela as char(1)),'V'), ifnull(CAST(feriadoTabela as char(1)),'V'), @realDate -- ifnull só por segurança e o as char(1) tmb 
					);
	END LOOP;
    
    CLOSE cur1;
END$$

CALL fillDate();

-- test select
SELECT	day(STR_TO_DATE(data, '%d-%m-%Y')), month(STR_TO_DATE(data, '%d-%m-%Y')), year(STR_TO_DATE(data, '%d-%m-%Y')),
		dayofweek(STR_TO_DATE(data, '%d-%m-%Y')), weekofyear(STR_TO_DATE(data, '%d-%m-%Y')),
		CAST(util as char(1)), CAST(feriado as char(1)), STR_TO_DATE(data, '%d-%m-%Y')
FROM sakila_dsa.calendario;
                    
-- verificar fillDate
select * from sakila_dw.dim_date
	LIMIT 0, 10000;
    
-- apagar dados inseridos
DELETE FROM sakila_dw.dim_date
	WHERE date_id > 0;
    
-- resetar AUTO-INCREMENT
ALTER TABLE sakila_dw.dim_date AUTO_INCREMENT = 1;