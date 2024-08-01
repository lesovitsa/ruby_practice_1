class Auth < ApplicationRecord
    has_secure_password
    validates :email, presence: true
    validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
    validates :role, presence: true
    validates :role, acceptance: { accept: ["admin", "client"]}
end
