class Message < ActiveRecord::Base
  validates :content, presence: true
  validates :recipient, presence: true
  belongs_to :user
end
