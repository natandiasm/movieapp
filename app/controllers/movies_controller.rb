class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Movie.all
    respond_to do |format|
      format.html
      format.json { render json: @movies.to_json(methods: :average_score) }
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "Movie was successfully created."
    else
      render :new
    end
  end

  def import_form
    # Renderize a view form
  end

  def import_csv
    # Get csv from form
    movies_csv = params[:movies_csv]
    # Save CSV on temp folder
    temp_path = helpers.save_file_temp_csv(movies_csv)
    if helpers.csv_has_headers?(temp_path, ['title', 'director'])
      # Call async job
      job_movies = MoviesJob.perform_async(temp_path)

      redirect_to movies_path, notice: 'Import has started, soon your movies will be imported.'
    else
      flash[:error] = "The CSV format sent is not accepted, send a file containing only the title and director of the movie."
      redirect_to movies_path
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :director)
  end
end
