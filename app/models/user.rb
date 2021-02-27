class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 20}
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  has_secure_password 
end
