class Item < ActiveRecord::Base
  validates :title, presence: true
  validates :price, presence: true
  validates :description, presence: true
  belongs_to :user
end
