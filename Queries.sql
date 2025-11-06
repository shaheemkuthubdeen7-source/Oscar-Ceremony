/*This Query will give us the NominationIDs of the people or files that won an award*/

SELECT NominationID
FROM Nomination
WHERE Winner = TRUE;


/*This Query will give us the ID and name of anyone starting with the letter D*/
SELECT PersonID, FullName
FROM Person
WHERE FullName LIKE 'D%';


/*This Query show the ceremonyIDs after 2015*/
SELECT CeremonyID, Year
FROM Ceremony
WHERE CAST(Year AS UNSIGNED) > 2020
ORDER BY Year;


/*This Query will perform string manipulation and convert the Title to Upper case*/
SELECT FilmID, UPPER(Title) AS UppercaseTitle
FROM Film;


/*This Query will find awards which contains the word Best in it*/
SELECT CategoryID, DisplayName
FROM AwardCategory
WHERE DisplayName LIKE '%Best%';


/*This Query will list how many nominations each award category received*/
SELECT ac.DisplayName AS Category, COUNT(a.NominationID) AS NominationCount
FROM AwardCategory ac
LEFT JOIN Awards a ON ac.CategoryID = a.CategoryID
GROUP BY ac.DisplayName
ORDER BY NominationCount DESC;


/*This Query will list the people who worked on more than one film*/
SELECT p.FullName, COUNT(ao.FilmID) AS FilmCount
FROM Apart_Of ao
JOIN Person p ON ao.PersonID = p.PersonID
GROUP BY p.PersonID
HAVING COUNT(ao.FilmID) > 1
ORDER BY FilmCount DESC;


/*This Query will tell us what award did Ford v Ferrari win*/
SELECT ac.DisplayName AS AwardCategory, ac.AwardClass
FROM Film f
JOIN Nomination n ON f.NominationID = n.NominationID
JOIN Awards a ON n.NominationID = a.NominationID
JOIN AwardCategory ac ON a.CategoryID = ac.CategoryID
WHERE f.Title = 'Ford v Ferrari' AND n.Winner = TRUE;


/*This Query will show us the films that have won an award and which year they did it in*/
SELECT DISTINCT
    f.Title AS Film,
    c.Year AS YearWon
FROM Film f
JOIN Nomination n ON f.NominationID = n.NominationID
JOIN Ceremony c ON n.CeremonyID = c.CeremonyID
WHERE n.Winner = TRUE
  AND f.Title IS NOT NULL
  AND TRIM(f.Title) <> ''
ORDER BY f.Title, c.Year;


/*This Query will show us the people that have won awards and for what film (If available)*/
SELECT 
    p.FullName AS Person,
    f.Title AS Film,
    ac.DisplayName AS AwardCategory
FROM Person p
JOIN Apart_Of ao ON p.PersonID = ao.PersonID
JOIN Film f ON ao.FilmID = f.FilmID
JOIN Nomination n ON f.NominationID = n.NominationID
JOIN Awards a ON n.NominationID = a.NominationID
JOIN AwardCategory ac ON a.CategoryID = ac.CategoryID
WHERE n.Winner = TRUE
ORDER BY p.FullName, f.Title, ac.DisplayName;


