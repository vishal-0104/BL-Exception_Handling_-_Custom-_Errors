class UsersController < ApplicationController
  # POST /users (Create User)
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /users/:id (Fetch a User)
  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  # GET /users (Fetch All Users)
  def index
    users = User.all
    render json: users
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
