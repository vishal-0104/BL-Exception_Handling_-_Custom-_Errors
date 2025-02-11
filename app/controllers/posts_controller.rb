class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :authorize_user!, only: [:update, :destroy]

  # GET /posts/user/:user_id
  def user_posts
    user = User.includes(:posts).find_by(id: params[:user_id])

    if user
      render json: user.posts
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  # GET /posts/:id
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /posts/:id
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /posts/:id
  def destroy
    @post.destroy
    render json: { message: "Post deleted successfully" }, status: :ok
  end

  private

  # Find post by ID with error handling
  def set_post
    @post = Post.find_by(id: params[:id])

    unless @post
      render json: { error: "Post not found" }, status: :not_found
    end
  end

  # Strong parameters
  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end

  # Ensure only the owner can modify the post
  def authorize_user!
    unless @post.user_id == params[:user_id].to_i
      render json: { error: "You are not authorized to modify this post" }, status: :forbidden
    end
  end
end
