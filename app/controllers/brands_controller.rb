class BrandsController < ApplicationController
    before_action :authorized_admin, only: [:register]

    def register
        @brand = Brand.create(brand_params)
        if @brand.valid?
            render json: {brand: @brand}
        else
            render json: {error: "Error registering brand"}
        end
    end

    private

    def brand_params
        params.permit(:name, :state, :brand_id)
    end
end
