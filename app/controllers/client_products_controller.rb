require 'securerandom'

class ClientProductsController < ApplicationController
    before_action :authorized_admin, only: [:add_product_to_client, :remove_product_from_client, :set_payout_rate, :set_state]

    def add_product_to_client
        struct = client_product_params.merge({ conn_id: SecureRandom.uuid })
        @client_product = ClientProduct.create(struct)

        if @client_product.valid?
            render json: {
                client_product: @client_product
            }, status: 200
        else
            render json: {
                error: "Error registering product to client"
            }, status: 400
        end
    end

    def remove_product_from_client
        @client_product = ClientProduct.find(client_product_params[:conn_id])

        @client_product.destroy
        render json: {
            message: "Product removed from client"
        }, status: 200
    end

    def set_payout_rate
        if !client_product_params[:conn_id]
            render json: {
                error: "Could not find client product"
            }, status: 400
        else
            @client_product = ClientProduct.find(client_product_params[:conn_id])
            if @client_product[:payout_rate] != client_product_params[:payout_rate] && 
                (@client_product[:client_id] == client_product_params[:client_id] || !client_product_params[:client_id]) &&
                (@client_product[:prod_id] == client_product_params[:prod_id] || !client_product_params[:prod_id]) && 
                (@client_product[:state] == client_product_params[:state] || !client_product_params[:state])
                @client_product.update(client_product_params)
                @client_product.reload
                render json: {
                    client_product: @client_product
                }, status: 200
            else 
                render json: {
                    error: "Could not update client product",
                    current: @client_product,
                    requested: client_product_params
                }, status: 400
            end
        end
    end

    def set_state
        if !client_product_params[:conn_id]
            render json: {
                error: "Could not find client product"
            }, status: 400
        else
            @client_product = ClientProduct.find(client_product_params[:conn_id])
            if @client_product[:state] != client_product_params[:state] && 
                (@client_product[:client_id] == client_product_params[:client_id] || !client_product_params[:client_id]) &&
                (@client_product[:prod_id] == client_product_params[:prod_id] || !client_product_params[:prod_id]) && 
                (@client_product[:payout_rate] == client_product_params[:payout_rate] || !client_product_params[:payout_rate])
                @client_product.update(client_product_params)
                @client_product.reload
                render json: {
                    client_product: @client_product
                }, status: 200
            else 
                render json: {
                    error: "Could not update client product",
                    current: @client_product,
                    requested: client_product_params
                }, status: 400
            end
        end
    end
        

    private

    def client_product_params
        params.permit(:client_id, :prod_id, :conn_id, :state, :payout_rate)
    end
end
