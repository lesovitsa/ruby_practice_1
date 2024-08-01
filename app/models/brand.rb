class Brand < ApplicationRecord
    validates :brand_id, presence: true
    validates :state, acceptance: { accept: ["active", "inactive"]}
end
