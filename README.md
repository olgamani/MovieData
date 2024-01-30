###############################################
# MovieData Application Readme

## Overview
The MovieData application allows users to fetch and manage information about currently playing movies using The Movie DB (TMDB) API. It integrates with an SQLite database to store and retrieve movie details.

## Prerequisites
- Ruby installed on your machine (https://www.ruby-lang.org/)

## Setup (Using Replit)
1. Fork this repository and import it into your Replit account.
2. Open the Replit IDE for your project.

## Configuration
1. Obtain a TMDB API key by registering on the TMDB website: https://www.themoviedb.org/
2. Open the `config/config.rb` file in the Replit IDE and replace the placeholder with your TMDB API key:

    ```ruby
    # config/config.rb

    module Config
      API_KEY = 'your-tmdb-api-key'
      BASE_URL = 'https://api.themoviedb.org/3'
      REGION = 'GR' # Set your desired region code
    end
    ```

## Usage
1. Run the main script in the Replit IDE:

    ```bash
    ruby main.rb
    ```

2. The application will fetch and display information about currently playing movies.
3. Follow the on-screen menu to search for movies, update movie information, or exit the program.
4. For search, enter a keyword to find movies with matching titles.
5. For updating movie information, enter the ID of the movie you want to update and follow the prompts.

## Additional Notes
- The application uses SQLite as the default database, creating a `movies.db` file in the Replit project directory.

## External Systems
- **The Movie DB (TMDB):** The application uses TMDB API to fetch information about currently playing movies. Ensure you have a valid API key and configure it in `config.rb`.

###############################################
# Files Directory
```ruby
MovieData/
|-- config/
|   `-- config.rb
|-- lib/
|   |-- tmdb_api.rb
|   |-- database.rb
|   `-- movie_operations.rb
|-- main.rb
|-- README.txt
|-- schema.sql
`-- movies.db
```
## Directory Structure Explanation:

- **config/:** Contains configuration files.
  - **config.rb:** Holds configuration constants, including the TMDB API key, base URL, and region.

- **lib/:** Contains the main scripts and modules of the application.
  - **tmdb_api.rb:** Module for interacting with The Movie DB (TMDB) API. Defines methods to fetch movies, directors, and IMDB links.
  - **database.rb:** Module for handling database-related operations. Defines methods to connect to SQLite, create the movies table, and interact with the database.
  - **movie_operations.rb:** Module for movie-related operations. Defines methods to insert or update movies in the database, print movie information, search for movies, and update movie details.
  - **main.rb:** The main entry point of the application. Orchestrates the execution, fetches movie data, interacts with the database, and provides a user interface through the command line.

- **README.txt:** Detailed explanation of the application, its structure, and usage instructions.

- **schema.sql:** SQL file containing the DDL for database schema.

- **movies.db:** SQLite database file where movie data is stored.