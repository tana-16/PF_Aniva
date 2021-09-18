class Post < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :category

  validates :image, presence: true
  validates :body, presence: true
  validates :category, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
