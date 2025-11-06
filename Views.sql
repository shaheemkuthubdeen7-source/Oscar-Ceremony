-- View which combines Person, Nomination and Ceremony.
CREATE VIEW View_PersonNomination AS
SELECT 
    p.PersonID,
    p.FullName,
    n.NominationID,
    n.Winner AS IsWinner,
    c.Year AS CeremonyYear
FROM Person p
JOIN Nomination n ON p.NominationID = n.NominationID
JOIN Ceremony c ON n.CeremonyID = c.CeremonyID;


-- View which combines Film, Awards and AwardCategory

CREATE VIEW View_FilmAwards AS
SELECT 
    f.FilmID,
    f.Title AS FilmTitle,
    ac.DisplayName AS AwardName,
    ac.AwardClass
FROM Film f
JOIN Awards a ON f.NominationID = a.NominationID
JOIN AwardCategory ac ON a.CategoryID = ac.CategoryID;

