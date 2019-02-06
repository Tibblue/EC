select * from athlete_events;

DROP PROCEDURE IF EXISTS populate_tables;

-- CURSOR PROCEDURE
DELIMITER $$
CREATE PROCEDURE populate_tables()
BEGIN
-- declare vars
  DECLARE done INT DEFAULT FALSE;
  DECLARE id_ath, id_game, year_game  INT;
  DECLARE name_ath, sex_ath, season_game, desc_game, design_event, design_medal, design_team, design_city TEXT;
  
   -- declare cursors
  DECLARE athlete_cursor CURSOR FOR SELECT DISTINCT id_athlete, name_athlete, sex FROM ficha2.athlete_events;
  DECLARE others_cursor CURSOR FOR SELECT DISTINCT  id, team, games, year, season, city, event, medal FROM ficha2.athlete_events;

  -- declare NOT FOUND handler
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN athlete_cursor;
  OPEN others_cursor;

  read_loop: LOOP
    FETCH athlete_cursor INTO   id_ath, name_ath, sex_ath;
  FETCH others_cursor INTO  id_game, design_team, desc_game, year_game, 
                season_game, design_city, design_event, design_medal;
    
    IF done THEN
      LEAVE read_loop;
    END IF;
       INSERT INTO athlete VALUES (id_ath,name_ath,sex_ath);
       INSERT INTO city VALUES (NULL,design_city);
       INSERT INTO event VALUES (NULL,design_event);
       INSERT INTO game VALUES (id_game,desc_game,year_game,season_game);
       INSERT INTO medal VALUES (NULL,design_medal);
       INSERT INTO team VALUES (NULL,design_team);
  END LOOP;

  CLOSE athlete_cursor;
  CLOSE others_cursor;
END$$

-- CALL PROCEDURE
CALL populate_tables();


-- SELECT
SELECT * FROM athlete;

SELECT * FROM city;

SELECT * FROM event;

SELECT * FROM game;

SELECT * FROM medal;

SELECT * FROM team;

