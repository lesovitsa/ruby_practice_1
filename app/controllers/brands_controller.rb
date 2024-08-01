require 'securerandom'

class BrandsController < ApplicationController
    before_action :authorized_admin, only: [:register, :update_brand]

    def register
        struct = brand_params.merge({ brand_id: SecureRandom.uuid })
        @brand = Brand.create(struct)

        if @brand.valid?
            Log.create({
                log_id: SecureRandom.uuid,
                user_id: get_current_user_id,
                action: "Register brand",
                brand_id: struct[:brand_id]
            })
            render json: {
                brand: @brand
            }, status: 200
        else
            Log.create({
                log_id: SecureRandom.uuid,
                user_id: get_current_user_id,
                action: "Failed to register brand",
            })
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
            Log.create({
                log_id: SecureRandom.uuid,
                user_id: get_current_user_id,
                action: "Update brand",
                brand_id: @brand[:brand_id]
            })
            render json: {
                brand: @brand
            }, status: 200
        else
            Log.create({
                log_id: SecureRandom.uuid,
                user_id: get_current_user_id,
                action: "Failed to update brand",
                brand_id: @brand[:brand_id]
            })
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
