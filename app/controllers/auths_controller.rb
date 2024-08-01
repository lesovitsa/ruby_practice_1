require 'securerandom'

class AuthsController < ApplicationController
    skip_before_action :authorized, only: [:create_client, :login]
    before_action :authorized_admin, only: [:add_admin, :add_client]
    
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

    # ADD CLIENT AS ADMIN
    def add_client
        add_user("client", parameters)
    end

    
    private

    def add_user(role)
        struct = auth_params.merge({userid: SecureRandom.uuid})
        if struct[:role] != role
            render json: {error: struct}
        else
            @user = Auth.create(struct)
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