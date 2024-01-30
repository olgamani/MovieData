# MovieData/lib/database.rb
require 'sqlite3'

module Database
  extend self

  # Function to connect to SQLite database
  def connect(database_name)
    SQLite3::Database.new(database_name)
  end

  # Function to create movies table in the database
  def create_movies_table(database)
    database.execute <<-SQL
      CREATE TABLE IF NOT EXISTS movies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        original_title TEXT,
        directors TEXT,
        imdb_link TEXT
      );
    SQL
  end
end
