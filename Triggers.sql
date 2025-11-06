
-- Trigger to check if the year entered into ceremony table is valid
DROP TRIGGER IF EXISTS check_valid_ceremony_year;
DELIMITER $$

CREATE TRIGGER check_valid_ceremony_year
BEFORE INSERT ON Ceremony
FOR EACH ROW
BEGIN
    DECLARE v_year_int INT;

    -- Convert the string year to integer (since it's VARCHAR)
    SET v_year_int = CAST(NEW.Year AS UNSIGNED);

    -- Check if the year is outside the allowed range
    IF v_year_int < 1927 OR v_year_int > 2025 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid Year: Ceremony year must be between 1927 and 2025.';
    END IF;
END$$

DELIMITER ;

-- Trigger to check if the award class entered is included in the pre set values
DROP TRIGGER IF EXISTS check_valid_awardclass;
DELIMITER $$

CREATE TRIGGER check_valid_awardclass
BEFORE INSERT ON AwardCategory
FOR EACH ROW
BEGIN
    IF NEW.AwardClass NOT IN ('Acting','Directing','Production','Title','Writing','Special','SciTech','Music') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid AwardClass: must be one of (Acting, Directing, Production, Title, Writing, Special, SciTech, Music).';
    END IF;
END$$

DELIMITER ;

