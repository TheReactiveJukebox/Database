--- switch into database reactivejukebox
\connect reactivejukebox

--- insert reason data in table feedbackreason
INSERT INTO "feedbackreason" ("id", "description") VALUES
	(1, 'Interpret'),
    (2, 'Song'),
    (3, 'Tempo'),
    (4, 'Genre'),
    (5, 'Dynamik'),
    (6, 'Zeitraum'),
    (7, 'Stimmung');
