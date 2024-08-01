require 'securerandom'

class BrandsController < ApplicationController
    before_action :authorized_admin, only: [:register, :update_brand]

    def register
        struct = brand_params.merge({brand_id: SecureRandom.uuid})
        @brand = Brand.create(struct)
        if @brand.valid?
            render json: {brand: @brand}
        else
            render json: {error: "Error registering brand"}
        end
    end

    def update_brand
        @brand = Brand.find(brand_params[:brand_id])
        if @brand.valid?
            @brand.update(brand_params)
            @brand.reload
            render json: {brand: @brand}
        else
            render json: {error: "Error updating brand"}
        end
    end

    private

    def brand_params
        params.permit(:name, :state, :brand_id)
    end
end
