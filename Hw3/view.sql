CREATE VIEW CharactersPlayed (name, nationality, character, year)
AS select a.name, a.nationality,  s.character, m.year from Actors a, 
Movies m, StarsIn s where s.actor_id = a.actor_id and s.movie_id = m.movie_id;