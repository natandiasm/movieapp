require 'csv'

class ScoresJob
  include Sidekiq::Job

  def perform(user_id, csv_path)
    user = User.find(user_id)
    CSV.foreach(csv_path, headers: true) do |row|
      begin
        @movie = Movie.find(row["movie_id"])
        user.movies << @movie
        @user_movie = user.user_movies.find_by(movie_id: @movie.id)
        @user_movie.update(score: row["score"])
      rescue => except
        puts except
      end
    end
  end
end
