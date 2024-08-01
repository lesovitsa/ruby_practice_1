class Brand < ApplicationRecord
    validates :brand_id, presence: true
    validates :state, :inclusion=> { :in=> ["active", "inactive"] }
end
