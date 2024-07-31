class ProductsController < ApplicationController
    before_action :authorized_admin, only: [:register]

    def register
        @product = Product.create(product_params)
        if @product.valid?
            render json: {product: @product}
        else
            render json: {error: "Error registering product"}
        end
    end

    private

    def product_params
        params.permit(:name, :state, :description, :product_id)
    end
end
