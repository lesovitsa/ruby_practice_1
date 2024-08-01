class ClientCatalogsController < ApplicationController
    before_action :authorized_client

    def get_all
        @all_products = ClientProduct.all.where(client_id: get_current_user_id)
        
        Log.create({
            log_id: SecureRandom.uuid,
            user_id: get_current_user_id,
            action: "Client viewed all products",
            client_id: get_current_user_id
        })
        
        render json: {
            all_products: @all_products.map { |prod| format_product(prod) }
        }, status: 200
    end

    def get_by_product_id
        if !catalog_params[:product_id]
            render json: {
                error: "Invalid argument"
            }, status: 400
            return
        end

        @all_products = ClientProduct.all.where(client_id: get_current_user_id).map { |prod| format_product(prod) }
        @matching_products = @all_products.select{ |product| product[:product][:product_id] == catalog_params[:product_id] }

        Log.create({
            log_id: SecureRandom.uuid,
            user_id: get_current_user_id,
            action: "Client viewed all products by product",
            product_id: catalog_params[:product_id],
            client_id: get_current_user_id
        })

        render json: {
            matching_products: @matching_products
        }, status: 200
    end

    def get_by_brand_id
        if !catalog_params[:brand_id]
            render json: {
                error: "Invalid argument"
            }, status: 400
            return
        end

        @all_products = ClientProduct.all.where(client_id: get_current_user_id).map { |prod| format_product(prod) }
        @matching_products = @all_products.select{ |product| product[:brand][:brand_id] == catalog_params[:brand_id] }

        Log.create({
            log_id: SecureRandom.uuid,
            user_id: get_current_user_id,
            action: "Client viewed all products by brand",
            brand_id: catalog_params[:brand_id],
            client_id: get_current_user_id
        })

        render json: {
            matching_products: @matching_products
        }, status: 200
    end


    private

    def catalog_params
        params.permit(:brand_id, :product_id)
    end
    
    def format_product(client_product)
        @brand_ownership = BrandOwnership.find(client_product[:prod_id])
        @brand = Brand.find(@brand_ownership[:brand_id])
        @product = Product.find(@brand_ownership[:product_id])

        return {
            brand: @brand,
            product: @product,
            payout_rate: client_product[:payout_rate],
            reference_id: client_product[:conn_id]
        }
    end
end
