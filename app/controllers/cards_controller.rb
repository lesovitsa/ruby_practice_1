require 'securerandom'

class CardsController < ApplicationController
    before_action :authorized_client, only: [:request_card, :cancel, :get_all_cards]

    def request_card
        @pin = rand.to_s[2..7] if card_params[:pin_requested]

        @card = Card.create(card_params.slice(:prod_id).merge({
            card_id: SecureRandom.uuid,
            card_number: rand.to_s[2..19],
            activation_number: SecureRandom.hex,
            client_id: get_current_user_id,
            pin: @pin
        }))

        if @card.valid?
            Log.create({
                log_id: SecureRandom.uuid,
                user_id: get_current_user_id,
                action: "Card request",
                client_id: get_current_user_id,
                card_id: @card[:card_id]
            })
            render json: {
                card: @card
            }, status: 200
        else
            Log.create({
                log_id: SecureRandom.uuid,
                user_id: get_current_user_id,
                action: "Failed card request",
                client_id: get_current_user_id
            })
            render json: {
                error: "Error creating card"
            }, status: 400
        end
    end

    def cancel
        @card = Card.find(card_params[:card_id])

        if @card[:client_id] != get_current_user_id
            Log.create({
                log_id: SecureRandom.uuid,
                user_id: get_current_user_id,
                action: "Failed to cancel card: unauthorized",
                client_id: get_current_user_id,
                card_id: @card[:card_id]
            })
            render json: {
                message: "Unauthorized"
            }, status: 401
        else
            @card.destroy
            Log.create({
                log_id: SecureRandom.uuid,
                user_id: get_current_user_id,
                action: "Cancelled card",
                client_id: get_current_user_id,
                card_id: @card[:card_id]
            })
            render json: {
                message: "Card cancelled"
            }, status: 200
        end
    end

    def get_all_cards
        @all_cards = Card.all.where(client_id: get_current_user_id)
        Log.create({
            log_id: SecureRandom.uuid,
            user_id: get_current_user_id,
            action: "Card list request",
            client_id: get_current_user_id
        })
        render json: {
            all_cards: @all_cards.map { |card| format_card(card) }
        }, status: 200
    end

    def use
        Log.create({
            log_id: SecureRandom.uuid,
            user_id: get_current_user_id,
            action: "Card use",
            client_id: get_current_user_id,
            card_id: card_params[:card_id]
        })
        render json: {
            message: "Card used"
        }, status: 200 # this method will not be implemented at this time
    end

    private

    def card_params
        params.permit(:pin_requested, :prod_id, :card_id)
    end
    
    def format_card(card)
        @brand_ownership = BrandOwnership.find(card[:prod_id])
        @brand = Brand.find(@brand_ownership[:brand_id])
        @product = Product.find(@brand_ownership[:product_id])

        return {
            brand: @brand,
            product: @product,
            card: card[:card_id]
        }
    end
end
