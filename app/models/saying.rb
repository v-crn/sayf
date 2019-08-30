class Saying < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, ImageUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }
  validate :picture_size
  has_many :favorites, dependent: :destroy

  def self.search_with(keywords)
    return none if keywords.blank?

    keywords = keywords.split(/[[:blank:]]+/).select(&:present?)
    excluding_terms, including_terms =
      keywords.partition { |keyword| keyword.start_with?('-') && keyword.length >= 2 }

    including_terms = [including_terms.map { |term| "%#{term}%" }.join]
    excluding_terms = [excluding_terms.map { |term| "%#{term.delete_prefix('-')}%" }.join]

    return Saying.where('content NOT LIKE ?', excluding_terms) if including_terms.select(&:present?).empty?

    Saying.where('content LIKE ?', including_terms)
          .where('content NOT LIKE ?', excluding_terms)
  end

  def favorite_points_by(user)
    favorites.where(user_id: user.id).count
  end

  def is_favorite_of?(user)
    favorites.find_by(user_id: user.id).present?
  end

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
  end
end
