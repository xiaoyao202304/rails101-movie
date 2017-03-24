class ReviewsController < ApplicationController
  before_action :authenticate_user!, only:[:create,:destroy]

  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to movie_path(@movie), notice: "评论添加成功"
    else
      redirect_to movie_path(@movie), alert: "评论不能为空"
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to movie_path(@movie), alert: "评论已删除"
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
