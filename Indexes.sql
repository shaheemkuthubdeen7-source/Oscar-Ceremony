-- Index to speed up joins and lookup's of Person and Nomination
CREATE INDEX idx_person_nomination
ON Person (NominationID);

-- Index to optimize Film, Awards and AwardCategory

CREATE INDEX idx_film_nomination_award
ON Film (NominationID);

