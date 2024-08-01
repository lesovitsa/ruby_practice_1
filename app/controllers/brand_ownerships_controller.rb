require 'securerandom'

class BrandOwnershipsController < ApplicationController
    before_action :authorized_admin, only: [:add_product_to_brand, :remove_product_from_brand]

    def add_product_to_brand
        struct = brand_ownership_params.merge({ conn_id: SecureRandom.uuid })
        @brand_ownership = BrandOwnership.create(struct)

        if @brand_ownership.valid?
            Log.create({
                log_id: SecureRandom.uuid,
                user_id: get_current_user_id,
                action: "Add product to brand",
                product_id: struct[:product_id],
                brand_id: struct[:brand_id]
            })
            render json: {
                brand_ownership: @brand_ownership
            }, status: 200
        else
            render json: {
                error: "Error registering product to brand"
            }, status: 400
        end
    end

    def remove_product_from_brand
        @brand_ownership = BrandOwnership.find(brand_ownership_params[:conn_id])

        @brand_ownership.destroy

        Log.create({
            log_id: SecureRandom.uuid,
            user_id: get_current_user_id,
            action: "Remove product from brand",
            product_id: @brand_ownership[:product_id],
            brand_id: @brand_ownership[:brand_id]
        })
        render json: {
            message: "Product removed from brand"
        }, status: 200
    end

    private

    def brand_ownership_params
        params.permit(:brand_id, :product_id, :conn_id)
    end
end
