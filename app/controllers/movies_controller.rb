class MoviesController < ApplicationController
    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index

      if session[:ratings_to_show]
        @ratings_to_show = session[:ratings_to_show]
      end

      @movies = Movie.all
      @all_ratings = Movie.return_ratings
      @ratings_to_show = Movie.checked_ratings(params[:ratings])
      

      if @ratings_to_show.nil?
        @movies = Movie.all
      else
        @movies = Movie.where('rating IN (?)', @ratings_to_show)
      end

      if params[:sort]
        if params[:sort] == "title_sort"
          session[:sort] = "title_sort"
          @movies = @movies.order(:title)
          params[:sorted_title] = "1"
          session[:sorted_title] = "1"
        elsif params[:sort] == "date_sort"
          session[:sort] = "date_sort"
          @movies = @movies.order(:release_date)
          params[:sorted_date] = "1"
          session[:sorted_date] = "1"
        else
        end
      end
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
    
    
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
  end