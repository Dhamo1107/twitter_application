class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users
  has_many :tweets, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  def update_follower_counts
    update_columns(followers_count: followers.count, followees_count: followees.count)
  end
end
