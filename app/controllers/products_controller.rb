require 'securerandom'

class ProductsController < ApplicationController
    before_action :authorized_admin, only: [:register, :update_product]

    def register
        struct = product_params.merge({ product_id: SecureRandom.uuid })
        @product = Product.create(struct)

        if @product.valid?
            Log.create({
                log_id: SecureRandom.uuid,
                user_id: get_current_user_id,
                action: "Created product",
                product_id: struct[:product_id]
            })
            render json: {
                product: @product
            }, status: 200
        else
            Log.create({
                log_id: SecureRandom.uuid,
                user_id: get_current_user_id,
                action: "Failed to create product"
            })
            render json: {
                error: "Error registering product"
            }, status: 400
        end
    end

    def update_product
        @product = Product.find(product_params[:product_id])

        if @product.update(product_params)
            @product.reload
            Log.create({
                log_id: SecureRandom.uuid,
                user_id: get_current_user_id,
                action: "Updated product",
                product_id: @product[:product_id]
            })
            render json: {
                product: @product
            }, status: 200
        else
            Log.create({
                log_id: SecureRandom.uuid,
                user_id: get_current_user_id,
                action: "Failed to update product",
                product_id: @product[:product_id]
            })
            render json: {
                error: "Error updating product"
            }, status: 400
        end
    end

    private

    def product_params
        params.permit(:name, :state, :description, :product_id)
    end
end
