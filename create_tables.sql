-- Drop in reverse dependency order
DROP TABLE IF EXISTS Presents;
DROP TABLE IF EXISTS Awards;
DROP TABLE IF EXISTS Apart_Of;
DROP TABLE IF EXISTS Film;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Nomination;
DROP TABLE IF EXISTS AwardCategory;
DROP TABLE IF EXISTS Ceremony;


-- === Core tables ===

CREATE TABLE IF NOT EXISTS Ceremony (
    CeremonyID INT PRIMARY KEY,
    Year       VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS AwardCategory (
    CategoryID        VARCHAR(100) PRIMARY KEY,
    DisplayName       VARCHAR(100),
    CanonicalCategory VARCHAR(250),
    AwardClass        VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Nomination (
    NominationID VARCHAR(100) PRIMARY KEY,
    CeremonyID   INT,
    Winner       BOOL DEFAULT FALSE,
    CONSTRAINT fk_nom_ceremony
      FOREIGN KEY (CeremonyID) REFERENCES Ceremony(CeremonyID)
);


CREATE TABLE IF NOT EXISTS Person (
    PersonID     VARCHAR(32) PRIMARY KEY,
    FullName     VARCHAR(200) NOT NULL,
    NominationID VARCHAR(100),
    CONSTRAINT fk_person_nom
      FOREIGN KEY (NominationID) REFERENCES Nomination(NominationID)
);

CREATE TABLE IF NOT EXISTS Film (
    FilmID       VARCHAR(100) PRIMARY KEY,
    NominationID VARCHAR(100),
    Title        VARCHAR(255),
    CONSTRAINT fk_film_nom
      FOREIGN KEY (NominationID) REFERENCES Nomination(NominationID)
);


CREATE TABLE IF NOT EXISTS Apart_Of (
    FilmID   VARCHAR(100) NOT NULL,
    PersonID VARCHAR(32) NOT NULL,
    PRIMARY KEY (FilmID, PersonID),
    CONSTRAINT fk_apartof_film   FOREIGN KEY (FilmID)  REFERENCES Film(FilmID),
    CONSTRAINT fk_apartof_person FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

CREATE TABLE IF NOT EXISTS Awards (
    NominationID VARCHAR(100) NOT NULL,
    CategoryID    VARCHAR(100) NOT NULL,
    PRIMARY KEY (NominationID, CategoryID),
    CONSTRAINT fk_awards_nom  FOREIGN KEY (NominationID) REFERENCES Nomination(NominationID),
    CONSTRAINT fk_awards_cat  FOREIGN KEY (CategoryID)   REFERENCES AwardCategory(CategoryID)
);

CREATE TABLE IF NOT EXISTS Presents (
    CeremonyID INT NOT NULL,
    CategoryID  VARCHAR(100) NOT NULL,
    PRIMARY KEY (CeremonyID, CategoryID),
    CONSTRAINT fk_presents_cer FOREIGN KEY (CeremonyID) REFERENCES Ceremony(CeremonyID),
    CONSTRAINT fk_presents_cat FOREIGN KEY (CategoryID) REFERENCES AwardCategory(CategoryID)
);

