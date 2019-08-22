class User < ApplicationRecord
  validates :name, presence: true
  validates :profile, length: { maximum: 200 }
  mount_uploader :icon, ImageUploader

  # Devise
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Sayings
  has_many :sayings, dependent: :destroy

  # Follow
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy,
                                  inverse_of: :follower
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy,
                                   inverse_of: :followed
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # Favorites
  has_many :favorites, dependent: :destroy
  has_many :fav_sayings, through: :favorites, source: :saying

  def like(saying)
    return if saying.blank? || saying.id.blank?

    fav = favorites.find_or_create_by(saying_id: saying.id)
    fav.update(points: fav.points + 1)
  end

  def unlike(saying)
    return if saying.blank? || saying.id.blank?

    fav = favorites.find_by(saying_id: saying.id)
    return if fav.blank?

    fav.update(points: fav.points - 1)
    fav.destroy! if fav.points <= 0
  end

  def is_favorite?(saying)
    fav_sayings.include?(saying)
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
											WHERE follower_id = :user_id"
    Saying.where("user_id IN (#{following_ids}) OR
									user_id = :user_id", user_id: id)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしていればtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
end
