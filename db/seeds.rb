# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin = Auth.create(email: "admin@email.com", password: "dankpods123", role: "admin", name: "Admin Adminson", userid: "7bac3a09-79d0-4a58-933a-9597f3475da3")

client1 = Auth.create(email: "azfell@email.com", password: "crowley", role: "client", name: "A. Z. Fell", userid: "900f4d84-c6db-4294-9219-4481ebe3e408")
client2 = Auth.create(email: "crowleynotcrawley@email.com", password: "angel", role: "client", name: "Anthony J Crowley", userid: "512eec1d-58b4-4ebb-9742-4d73e050014b")

brand1 = Brand.create(name: "The Chattering Order", state: "inactive", brand_id: "6fe75651-dbae-43b1-9c31-21767d65e3fe")
brand2 = Brand.create(name: "Give Me Coffee or Give Me Death", state: "active", brand_id: "17dd9d0d-6d77-4a32-be86-da2080d8e5cd")
brand3 = Brand.create(name: "The Small Back Room", state: "active", brand_id: "4a60eb47-6ca3-45fb-a07d-127780b6add9")

product1 = Product.create(name: "Discount per purchase", state: "inactive", description: "Get a discount at your payout rate for every purchase", product_id: "8a2f6c56-ea3b-4197-a23e-ea3a93ebb846")
product2 = Product.create(name: "Loyalty points", state: "active", description: "Earn loyalty points for every purchase", product_id: "83ac73aa-f85b-4dcd-ab00-21c60bc54066")
product3 = Product.create(name: "Refer a friend", state: "active", description: "Earn discounts for every friend you bring", product_id: "80173f88-8ae5-4a6e-aa52-b41827d45e56")