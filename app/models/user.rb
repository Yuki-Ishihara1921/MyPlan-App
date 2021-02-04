class User < ApplicationRecord
    has_secure_password
    has_many :plans, dependent: :destroy
end
