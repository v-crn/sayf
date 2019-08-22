class Saying < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, ImageUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }
  validate :picture_size
  has_many :favorites, dependent: :destroy

  def favorites_total
    favorites.sum(:points)
  end

  def favorite_points(user)
    return 0 unless user || favorites.find_by(user_id: user.id)

    favorites.find_by(user_id: user.id).points
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
