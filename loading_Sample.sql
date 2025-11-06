
-- Make loads repeatable without FK errors
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE Apart_Of;
TRUNCATE TABLE Awards;
TRUNCATE TABLE Presents;
TRUNCATE TABLE Film;
TRUNCATE TABLE Person;
TRUNCATE TABLE Nomination;
TRUNCATE TABLE AwardCategory;
TRUNCATE TABLE Ceremony;

SET FOREIGN_KEY_CHECKS = 1;


LOAD DATA INFILE '/var/lib/mysql-files/Ceremony.csv'
INTO TABLE Ceremony
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(CeremonyID, Year);


LOAD DATA INFILE '/var/lib/mysql-files/ACat.csv'
INTO TABLE AwardCategory
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(CategoryID, AwardClass, DisplayName, CanonicalCategory);



LOAD DATA INFILE '/var/lib/mysql-files/Nom.csv'
INTO TABLE Nomination
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@NomID, @CeremonyID, @WinnerStr)
SET 
  NominationID = @NomID,
  CeremonyID = @CeremonyID,
  Winner = IF(@WinnerStr='True', 1, 0);


LOAD DATA INFILE '/var/lib/mysql-files/Person.csv'
IGNORE INTO TABLE Person
FIELDS TERMINATED BY ','
LINES  TERMINATED BY '\n'
IGNORE 1 ROWS
(PersonID, FullName, NominationID);

LOAD DATA INFILE '/var/lib/mysql-files/Film.csv'
IGNORE INTO TABLE Film
FIELDS TERMINATED BY ','
LINES  TERMINATED BY '\n'
IGNORE 1 ROWS
(FilmID, NominationID, Title);

LOAD DATA INFILE '/var/lib/mysql-files/ApartOf.csv'
IGNORE INTO TABLE Apart_Of
FIELDS TERMINATED BY ','
LINES  TERMINATED BY '\n'
IGNORE 1 ROWS
(FilmID, PersonID);

LOAD DATA INFILE '/var/lib/mysql-files/Awards.csv'
IGNORE INTO TABLE Awards
FIELDS TERMINATED BY ','
LINES  TERMINATED BY '\n'
IGNORE 1 ROWS
(NominationID, CategoryID);

LOAD DATA INFILE '/var/lib/mysql-files/Presents.csv'
IGNORE INTO TABLE Presents
FIELDS TERMINATED BY ','
LINES  TERMINATED BY '\n'
IGNORE 1 ROWS
(CeremonyID, CategoryID);
