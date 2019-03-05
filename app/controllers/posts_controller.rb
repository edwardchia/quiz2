class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
#   before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:destroy, :edit, :update]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @new_review = Review.new
    @reviews = @post.reviews.order(created_at: :desc)
  end

  def update
    @post = Post.find(params[:id])
    if @post.update post_params
      redirect_to @post
    else
      render :edit
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    if can?(:destroy, @post)
      @post.destroy
      redirect_to posts_path
    else
      redirect_to root_path, alert: "This is not your post!"
      # @post = Post.find(params[:id])
      @post.destroy

      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
    #requiring from post model these specific records
  end

  def authorize_user!
    redirect_to root_path, alert: "access denied" unless can? :crud, @post
  end
end
