class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @new_review = Review.new review_params
    @new_review.post = @post
    @new_review.user = current_user
    if @new_review.save
      redirect_to post_path(@post)
    else
      @reviews = @post.reviews.order(created_at: :desc)
      render posts_path
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if can? :destroy, @review
    @review.destroy
    redirect_to post_url(@review.post)
    else
        head :unauthorized
    end
  end

  private

  def review_params
    params.require(:review).permit(:description)
  end
end
