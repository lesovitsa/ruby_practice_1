class ClientProduct < ApplicationRecord
    validates :conn_id, presence: true
    validates :prod_id, presence: true
    validates :client_id, presence: true
    validates :payout_rate, presence: true
    validates :state, acceptance: { accept: ["active", "inactive"]}
end
