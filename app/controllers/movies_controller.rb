class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  #Here we use the tags from params to see if we need to order the title or release dates. We set the class to hilite accordingly.
  def index
    @all_ratings = Movie.ratingsVar

    #The set of ifs that will handle the ratings tags from the index.html. Will filter accordingly.
    if params[:ratings]
      @ratings = params[:ratings]
      session[:ratings] = params[:ratings].keys             #set session keys
      @movies = Movie.where(rating: params[:ratings].keys)  #filtering
    else
      @ratings = session[:ratings]                          #load the session keys.
      @movies = Movie.where(rating: @ratings)
    end
    
    #The set of ifs that will handle sorting. If a hyperlink is clicked, it will sent :sort tags to tell us what to do.
    if params[:sort] == 'title'
      @movies = @movies.order('title ASC')
      @title_hilighter = 'hilite'
      session[:sort] = params[:sort]
    elsif params[:sort] == 'release_date'
      @movies = @movies.order('release_date ASC') 
      @rdate_hilighter = 'hilite'
      session[:sort] = params[:sort]
    elsif session[:sort] == 'title'                   #Load session keys
      @movies = @movies.order('title ASC')
      @title_hilighter = 'hilite'
    elsif session[:sort] == 'release_date'            #Load session keys
      @movies = @movies.order('release_date ASC')
      @rdate_hilighter = 'hilite'
    end
    
    #if params[:sort] == 'title'
    #  @movies = @trimmed_movies.order('title ASC')
    #  @title_hilighter = 'hilite'
    #elsif params[:sort] == 'release_date'
    #  @movies = @trimmed_movies.order('release_date ASC')
    #  @rdate_hilighter = 'hilite'
    #else
    #  @movies = @trimmed_movies
    #end
    
    
    #session[:sort] = params[:sort]
    #session[:rating] = params[:ratings]
    
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
  
  def sort
    @movie = Movie.find(params[:id])
    redirect_to movies_path
  end
  
  #On click call a function that reorders and shows

end
