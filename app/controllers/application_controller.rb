class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from NotAuthorizedError, with: :user_not_authorized

  private

  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end

  def user_not_authorized(error)
    render json: { error: error.message }, status: :forbidden
  end
end
