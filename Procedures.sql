DROP PROCEDURE IF EXISTS ViewTables;
DELIMITER $$
CREATE PROCEDURE ViewTables(
    IN TableName VARCHAR(50)
)
COMMENT 'Procedure to View all or specific tables in the database'
BEGIN 
    -- IF statement to display Ceremony table if called
    IF TableName = 'Ceremony' THEN
        SELECT * FROM Ceremony;
        
    -- IF statement to display AwardCategory table if called    
    ELSEIF TableName = 'AwardCategory' THEN
        SELECT * FROM AwardCategory;
        
    -- IF statement to display Nomination table if called       
    ELSEIF TableName = 'Nomination' THEN
        SELECT * FROM Nomination;
        
    -- IF statement to display Person table if called     
    ELSEIF TableName = 'Person' THEN
        SELECT * FROM Person;
        
    -- IF statement to display Film table if called     
    ELSEIF TableName = 'Film' THEN
        SELECT * FROM Film;
     
    -- IF statement to display all tables if called  
    ELSEIF TableName = 'All' THEN
        SELECT * FROM Ceremony;
        SELECT * FROM AwardCategory;
        SELECT * FROM Nomination;
        SELECT * FROM Person;
        SELECT * FROM Film;   
    -- IF there are no valid tables give, an error message will display     
    ELSE 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Table does not exist.';
    END IF;
END$$
DELIMITER ;



DROP PROCEDURE IF EXISTS DeletePersonAndRelated;
DELIMITER $$
CREATE PROCEDURE DeletePersonAndRelated(
    IN p_PersonID VARCHAR(100)
)
BEGIN
    DECLARE v_NominationID VARCHAR(100);
    DECLARE v_FilmID VARCHAR(100);
    -- 1. Get the NominationID(s) linked to the person
    SELECT NominationID INTO v_NominationID
    FROM Person
    WHERE PersonID = p_PersonID;
    -- 2. Get FilmID(s) linked to the person
    SELECT FilmID INTO v_FilmID
    FROM Apart_Of
    WHERE PersonID = p_PersonID
    LIMIT 1; -- assuming 1 film per nomination; adjust if multiple
    -- 3. Delete from Apart_Of
    DELETE FROM Apart_Of
    WHERE PersonID = p_PersonID;
    -- 4. Delete the person
    DELETE FROM Person
    WHERE PersonID = p_PersonID;
    -- 5. Delete awards linked to nomination (optional: only if this nomination is now unused)
    DELETE FROM Awards
    WHERE NominationID = v_NominationID;
    -- 6. Delete film if it exists (optional: only if no other persons linked)
    IF v_FilmID IS NOT NULL THEN
        DELETE FROM Film
        WHERE FilmID = v_FilmID
          AND NOT EXISTS (SELECT 1 FROM Apart_Of WHERE FilmID = v_FilmID);
    END IF;
    -- 7. Delete nomination (optional: only if no other person or film uses it)
    DELETE FROM Nomination
    WHERE NominationID = v_NominationID
      AND NOT EXISTS (SELECT 1 FROM Person WHERE NominationID = v_NominationID)
      AND NOT EXISTS (SELECT 1 FROM Film WHERE NominationID = v_NominationID);
END$$
DELIMITER ;

