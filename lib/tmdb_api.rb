# MovieData/lib/tmdb_api.rb
require 'httparty'
require_relative '../config/config'

module TMDBApi
  extend self

  # Function to fetch movies from TMDB API
  def fetch_movies
    response = HTTParty.get("#{Config::TMDB_BASE_URL}/movie/now_playing", query: { api_key: Config::TMDB_API_KEY, region: Config::TMDB_REGION })
    movies = response['results'].map do |movie|
      directors = fetch_directors(movie['id'])
      imdb_link = fetch_imdb_link(movie['id'])

      {
        title: movie['title'],
        description: movie['overview'],
        original_title: movie['original_title'],
        directors: directors,
        imdb_link: imdb_link
      }
    end
    movies
  end

  # Function to fetch directors for a movie
  def fetch_directors(movie_id)
    response = HTTParty.get("#{Config::TMDB_BASE_URL}/movie/#{movie_id}/credits", query: { api_key: Config::TMDB_API_KEY })
    response['crew'].select { |member| member['job'] == 'Director' }.map { |director| director['name'] }
  end

  # Function to fetch IMDB link for a movie
  def fetch_imdb_link(movie_id)
    response = HTTParty.get("#{Config::TMDB_BASE_URL}/movie/#{movie_id}/external_ids", query: { api_key: Config::TMDB_API_KEY })
    response['imdb_id'] ? "https://www.imdb.com/title/#{response['imdb_id']}/" : ''
  end
end
