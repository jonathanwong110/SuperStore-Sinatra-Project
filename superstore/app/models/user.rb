class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
  validates :location, presence: true
  has_many :items
  has_many :messages
end
