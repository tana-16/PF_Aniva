class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum gender:{"男性": 0,"女性": 1,"その他": 2 }
  enum age:{"---": 0,"20歳未満": 1,"20代": 2,"30代": 3,"40代": 4,"50代": 5,"60代": 6,"70歳以上": 7 }

  attachment :profile_image

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # チャット機能
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :user_rooms
  # 通知機能
  # 自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
  # 相手からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # フォロー機能
  # フォロー取得
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォロワー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローしている人
  has_many :following_user, through: :follower, source: :followed
  # 自分をフォローしている人
  has_many :follower_user, through: :followed, source: :follower

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  def active_for_authentication?
    super && (self.user_status == false)
  end

  # 通知レコード作成
  def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    # 通知レコードが存在しない場合
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        visiter_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def self.search_for(content)
    User.where('name LIKE ?', '%'+content+'%')
  end

  # validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # validates :introduction, length: { maximum: 50 }

  # validates :profile_image, presence: true
  # validates :name, presence: true
  # validates :address, presence: true
  # validates :introduction, presence: false, length: { maximum: 200 }

end
