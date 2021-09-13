class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  enum gender:{"男性": 0,"女性": 1,"その他": 2 }
  enum age:{"---": 0,"20歳未満": 1,"20-29歳": 2,"30-39歳": 3,"40-49歳": 4,"50-59歳": 5,"60-69歳": 6,"70歳以上": 7 }
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
