class AuthsController < ApplicationController
    skip_before_action :authorized, only: [:create_client, :login]
    
    # REGISTER
    def add_admin
    end

    def create_client
        if auth_params[:role] != "client"
            render json: {error: "Invalid argument"}
            return
        end

        @user = Auth.create(auth_params)
        if @user.valid?
            token = encode_token({user_id: @user.id})
            render json: {user: @user, token: token}
        else
            render json: {error: "Invalid email or password"}
        end
    end
    
    # LOGGING IN
    def login
        @user = Auth.find_by(email: params[:email])
    
        if @user && @user.authenticate(params[:password])
        token = encode_token({user_id: @user.id})
        render json: {user: @user, token: token}
        else
        render json: {error: "Invalid email or password"}
        end
    end
    
    private
    
    def auth_params
        params.permit(:email, :password, :role)
    end
    
end