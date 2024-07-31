class AuthsController < ApplicationController
    skip_before_action :authorized, only: [:create_client, :login]
    before_action :authorized_admin, only: [:add_admin]
    
    # REGISTER
    def add_admin
        add_user("admin")
    end

    def create_client
        add_user("client")
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

    def add_user(role)
        if auth_params[:role] != role
            render json: {error: "Invalid argument"}
        else
            @user = Auth.create(auth_params)
            if @user.valid?
                token = encode_token({user_id: @user.id})
                render json: {user: @user, token: token}
            else
                render json: {error: "Invalid email or password"}
            end
        end
    end
    
    def auth_params
        params.permit(:email, :password, :role, :name, :userid)
    end
    
end