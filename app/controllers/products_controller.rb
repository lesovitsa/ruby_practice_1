class ProductsController < ApplicationController
    before_action :authorized_admin, only: [:register, :update_product]

    def register
        @product = Product.create(product_params)
        if @product.valid?
            render json: {product: @product}
        else
            render json: {error: "Error registering product"}
        end
    end

    def update_product
        @product = Product.find(product_params[:product_id])
        @product.update(product_params)
        @product.reload
        render json: {product: @product}
    end

    private

    def product_params
        params.permit(:name, :state, :description, :product_id)
    end
end
