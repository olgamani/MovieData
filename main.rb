# MovieData/main.rb
require_relative 'lib/tmdb_api'
require_relative 'lib/database'
require_relative 'lib/movie_operations'
require_relative 'config/config'

# Set your TMDB API key
API_KEY = Config::TMDB_API_KEY
BASE_URL = Config::TMDB_BASE_URL
REGION = Config::TMDB_REGION

# Main logic
begin
  # Fetch movies from TMDB API
  movies = TMDBApi.fetch_movies

  # Connect to the database and create movies table
  db = Database.connect('movies.db')
  Database.create_movies_table(db)

  # Insert or update movies in the database
  MovieOperations.insert_or_update_movies(db, movies)

  # Print movie information
  MovieOperations.print_movie_info(movies)

  loop do
    puts "\nMenu:"
    puts "1. Search for movies"
    puts "2. Update movie information"
    puts "3. Exit"
    print "Enter your choice: "
    choice = gets.chomp.to_i

    case choice
    when 1
      # Corrected method name: search_and_display
      MovieOperations.search_and_display(db)
    when 2
      MovieOperations.update_movie_information(db)
    when 3
      puts "Exiting the program. Goodbye!"
      break
    else
      puts "Invalid choice. Please enter a valid option."
    end
  end

rescue StandardError => e
  puts "An error occurred: #{e.message}"
ensure
  db&.close
end
