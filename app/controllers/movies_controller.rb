class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @sort = params[:sort]
    @all_ratings = ['G', 'PG', 'PG-13', 'R']
    @checked_ratings = @all_ratings
    @checked_ratings = params[:ratings].keys if params[:ratings]
    logger.debug(@checked_ratings)
    @movies = Movie.where(:rating => @checked_ratings)
    if @sort
      if @sort == "title"
        @movies = @movies.order(@sort)
      elsif @sort == "release_date"
        @movies = @movies.order(@sort)
      end
    end
    @movies = @movies.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
