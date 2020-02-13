class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def self.has_handle?(handle)
    if find_by(github_handle: handle)
      true
    else
      false
    end
  end

  def is_friends?(github_handle)
    if friends.where(github_handle: github_handle).length > 0
      true
    end
  end
end
