class Card < ApplicationRecord
    validates :card_id, presence: true
    validates :prod_id, presence: true
    validates :activation_number, presence: true
    validates :client_id, presence: true
    validates :card_number, presence: true
end
