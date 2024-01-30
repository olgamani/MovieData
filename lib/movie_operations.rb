# MovieData/lib/movie_operations.rb
require_relative 'tmdb_api'
require_relative 'database'
require_relative '../config/config'

module MovieOperations
  extend self

  # Function to insert or update data in the movies table
  def insert_or_update_movies(database, movies)
    movies.each do |movie|
      existing_movie = database.execute('SELECT * FROM movies WHERE title = ?', movie[:title]).first

      if existing_movie
        # Update the existing record
        database.execute('UPDATE movies SET title = ?, description = ?, original_title = ?, directors = ?, imdb_link = ? WHERE id = ?',
                          [movie[:title], movie[:description], movie[:original_title], movie[:directors].join(', '), movie[:imdb_link], existing_movie[0]])
      else
        # Insert a new record
        database.execute('INSERT INTO movies (title, description, original_title, directors, imdb_link) VALUES (?, ?, ?, ?, ?)',
                          [movie[:title], movie[:description], movie[:original_title], movie[:directors].join(', '), movie[:imdb_link]])
      end
    end
  end

  # Function to print movie information
  def print_movie_info(movies)
    puts 'Movie Information:'
    movies.each do |movie|
      movie.each do |key, value|
        key_str = key.is_a?(Symbol) ? key.to_s.capitalize : key.to_s.capitalize
        formatted_value = format_value(value)
        puts "#{key_str}: #{formatted_value}"
      end
      puts '------------------------'
    end
  end

  # Function to search movies by title and display
  def search_and_display(database)
    puts "\nEnter a keyword to search for movies (or press Enter to go back):"
    search_keyword = gets.chomp
    return if search_keyword.empty?

    search_results = search_movies(database, search_keyword)

    if search_results.empty?
      puts "No movies found with the keyword '#{search_keyword}'."
    else
      puts "\nSearch Results:"
      print_movie_info(search_results)
    end
  end

  # Function to update movie information
  def update_movie_information(database)
    puts "\nEnter the ID of the movie you want to update:"
    movie_id = gets.chomp.to_i

    movie_to_update = database.execute('SELECT * FROM movies WHERE id = ?', movie_id).first

    if movie_to_update
      puts "\nCurrent Information:"
      print_movie_info([{
        id: movie_to_update[0],
        title: movie_to_update[1],
        description: movie_to_update[2],
        original_title: movie_to_update[3],
        directors: movie_to_update[4].split(', '),
        imdb_link: movie_to_update[5]
      }])

      puts "\nEnter updated information:"
      updated_title = prompt_user_for_input("Enter updated title: ")
      updated_description = prompt_user_for_input("Enter updated description: ")
      updated_directors = prompt_user_for_input("Enter updated directors (comma-separated): ")
      updated_imdb_link = prompt_user_for_input("Enter updated IMDB link: ")

      updated_movie = {
        id: movie_id,
        title: updated_title,
        description: updated_description,
        directors: updated_directors.split(','),
        imdb_link: updated_imdb_link
      }

      # Update the movie information in the database
      database.execute('UPDATE movies SET title = ?, description = ?, original_title = ?, directors = ?, imdb_link = ? WHERE id = ?',
                        [updated_movie[:title], updated_movie[:description], updated_movie[:title], updated_movie[:directors].join(', '), updated_movie[:imdb_link], movie_id])

      puts "\nMovie information updated successfully!"
    else
      puts "Movie with ID #{movie_id} not found."
    end
  end

  private

  # Function to search movies by title
  def search_movies(database, search_keyword)
    database.execute('SELECT * FROM movies WHERE title LIKE ?', "%#{search_keyword}%").map do |movie|
      {
        id: movie[0],
        title: movie[1],
        description: movie[2],
        original_title: movie[3],
        directors: movie[4].split(', '), # Assuming directors are stored as a comma-separated string
        imdb_link: movie[5]
      }
    end
  end

  # Function to prompt user for input
  def prompt_user_for_input(prompt)
    print prompt
    gets.chomp
  end

  # Function to format values for display
  def format_value(value)
    case value
    when String
      value.capitalize
    when Array
      value.map { |v| format_value(v) }.join(', ')
    when Hash
      value.map { |k, v| "#{k.to_s.capitalize}: #{format_value(v)}" }.join(', ')
    else
      value.to_s
    end
  end
end
