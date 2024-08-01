class Product < ApplicationRecord
    validates :product_id, presence: true
    validates :state, :inclusion=> { :in=> ["active", "inactive"] }
end
