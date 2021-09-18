class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum gender:{"男性": 0,"女性": 1,"その他": 2 }
  enum age:{"---": 0,"20歳未満": 1,"20代": 2,"30代": 3,"40代": 4,"50代": 5,"60代": 6,"70歳以上": 7 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  attachment :profile_image

end
