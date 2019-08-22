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
  has_many :fav_sayings, -> { distinct }, through: :favorites, source: :saying

  def like(saying)
    favorites.create!(saying_id: saying.id)
  end

  def unlike(saying)
    favorites.find_by(saying_id: saying.id).destroy
  end

  def is_favorite?(saying)
    favorites.find_by(saying_id: saying.id).present?
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
