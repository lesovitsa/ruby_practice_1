class Product < ApplicationRecord
    validates :product_id, presence: true
    validates :state, acceptance: { accept: ["active", "inactive"]}
end
