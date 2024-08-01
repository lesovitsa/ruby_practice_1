class BrandOwnership < ApplicationRecord
    validates :brand_id, presence: true
    validates :product_id, presence: true
    validates :conn_id, presence: true
end
