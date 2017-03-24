class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :favorite]

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "新增电影成功"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to movies_path, notice: "已更新"
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, alert: "已删除"
  end

  def favorite
    @movie = Movie.find(params[:id])
    type = params[:type]
    if type == "favorite"
      current_user.favorite_movies << @movie
      flash[:notice] = "已收藏电影"
      redirect_to :back
    elsif type == "unfavorite"
      current_user.favorite_movies.delete(@movie)
      flash[:alert] = "已取消收藏"
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :image, :description)
  end

end
