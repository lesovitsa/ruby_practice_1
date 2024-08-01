require 'securerandom'

class ProductsController < ApplicationController
    before_action :authorized_admin, only: [:register, :update_product]

    def register
        struct = product_params.merge({ product_id: SecureRandom.uuid })
        @product = Product.create(struct)

        if @product.valid?
            render json: {
                product: @product
            }, status: 200
        else
            render json: {
                error: "Error registering product"
            }, status: 400
        end
    end

    def update_product
        @product = Product.find(product_params[:product_id])

        if @product.valid?
            @product.update(product_params)
            @product.reload
            render json: {
                product: @product
            }, status: 200
        else
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
