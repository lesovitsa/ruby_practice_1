class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, 'yourSecret')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 'yourSecret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = Auth.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def admin?
    logged_in_user[:role] == "admin"
  end

  def compare_user(id)
    render json: { message: "Unauthorized" }, status: :unauthorized unless logged_in_user[:userid] == id
  end

  def authorized
    render json: { message: "Please log in" }, status: :unauthorized unless logged_in?
  end

  def authorized_admin
    render json: { message: "Unauthorized" }, status: :unauthorized unless admin?
  end
end