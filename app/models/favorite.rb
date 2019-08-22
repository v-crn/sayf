class Favorite < ApplicationRecord
  belongs_to :saying
  belongs_to :user
  validates :user_id, presence: true
  validates :saying_id, presence: true
end
