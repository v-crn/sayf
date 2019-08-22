class Saying < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, ImageUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }
  validate :picture_size
  has_many :favorites, dependent: :destroy, counter_cache: true

  def favorite_points_by(user)
    favorites.where(user_id: user.id).count
  end

  def is_favorite_of?(user)
    favorites.find_by(user_id: user.id).present?
  end

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, 'should be less than 5MB')
    end
  end
end
