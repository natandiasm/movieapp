class UserMoviesController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = Movie.find(params[:user_movie][:movie_id])
    current_user.movies << @movie
    @user_movie = current_user.user_movies.find_by(movie_id: @movie.id)
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end

  def import_score
    # Renderize a view form
  end

  def import_score_csv
    if helpers.csv_has_headers?(temp_path, ['movie_id', 'score'])
      # Get csv from form
      scores_csv = params[:scores_csv]
      # Save CSV on temp folder
      temp_path = helpers.save_file_temp_csv(scores_csv)
      # Get current id user to add movies
      user_id = current_user.id
      # Call async job
      ScoresJob.perform_async(user_id, temp_path)

      redirect_to movies_path, notice: 'Import has started, soon your scores will be imported'
    else
      redirect_to movies_path, error: "The CSV format sent is not accepted, send a file containing only the movie_id and score of the movie"
    end

  end

  def update
    @user_movie = current_user.user_movies.find_by(movie_id: params[:user_movie][:movie_id])
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end
end
