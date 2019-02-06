SELECT * FROM athlete_events;

SELECT * FROM athlete;

DROP PROCEDURE IF EXISTS populate_athlete;

DELIMITER $$
CREATE PROCEDURE populate_athlete()
BEGIN
-- declare vars
  DECLARE done INT DEFAULT FALSE;
  DECLARE id  int;
  DECLARE name_ath, sex_ath TEXT;
  
   -- declare cursor for athletes id, name and sex
  DECLARE id_cur CURSOR FOR SELECT distinct id_athlete FROM athlete_events;
  DECLARE name_cur CURSOR FOR SELECT distinct name_athlete FROM athlete_events;
  DECLARE sex_cur CURSOR FOR SELECT sex FROM athlete_events;
  
  -- declare NOT FOUND handler
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN id_cur;
  OPEN name_cur;
  OPEN sex_cur;

  read_loop: LOOP
    FETCH id_cur INTO id;
    FETCH name_cur INTO name_ath;
    FETCH sex_cur INTO sex_ath;
    
    IF done THEN
      LEAVE read_loop;
    END IF;
      INSERT INTO athlete VALUES (id,name_ath,sex_ath);
  END LOOP;

  CLOSE id_cur;
  CLOSE name_cur;
  CLOSE sex_cur;
END$$

CALL populate_athlete();

SELECT * FROM athlete;
