class ClientProduct < ApplicationRecord
    validates :conn_id, presence: true
    validates :payout_rate, presence: true
    validates :state, :inclusion=> { :in=> ["active", "inactive"] }
end
