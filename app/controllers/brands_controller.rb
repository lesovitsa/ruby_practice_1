require 'securerandom'

class BrandsController < ApplicationController
    before_action :authorized_admin, only: [:register, :update_brand]

    def register
        struct = brand_params.merge({ brand_id: SecureRandom.uuid })
        @brand = Brand.create(struct)

        if @brand.valid?
            render json: {
                brand: @brand
            }, status: 200
        else
            render json: {
                error: "Error registering brand"
            }, status: 400
        end
    end

    def update_brand
        @brand = Brand.find(brand_params[:brand_id])

        if @brand.valid?
            @brand.update(brand_params)
            @brand.reload
            render json: {
                brand: @brand
            }, status: 200
        else
            render json: {
                error: "Error updating brand"
            }, status: 400
        end
    end

    private

    def brand_params
        params.permit(:name, :state, :brand_id)
    end
end
