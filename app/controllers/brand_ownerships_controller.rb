class BrandOwnershipsController < ApplicationController
    before_action :authorized_admin, only: [:add_product_to_brand, :remove_product_from_brand]

    def add_product_to_brand
        @brand_ownership = BrandOwnership.create(brand_ownership_params)
        if @brand_ownership.valid?
            render json: {brand_ownership: @brand_ownership}
        else
            render json: {error: "Error registering product to brand"}
        end
    end

    def remove_product_from_brand
        @brand_ownership = BrandOwnership.find(brand_ownership_params[:conn_id])

        @brand_ownership.destroy
        render json: {message: "Product removed from brand"}
    end

    private

    def brand_ownership_params
        params.permit(:brand_id, :product_id, :conn_id)
    end
end
