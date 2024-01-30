-- movies table schema
CREATE TABLE IF NOT EXISTS movies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  description TEXT,
  original_title TEXT,
  directors TEXT,
  imdb_link TEXT
);