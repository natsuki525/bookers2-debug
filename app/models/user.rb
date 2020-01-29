class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books
  accepts_nested_attributes_for :books
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # :foreign_key - 参照先のテーブルの外部キーのカラム名を指定できる
  # -------------自分がフォローしているユーザーとの関連-------------------
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  # -----------------------------------------------------------------

  # ------------自分がフォローされるユーザーとの関連----------------------
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  # ------------------------------------------------------------------

  # -----------チャット-----------------
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms
  # ------------------------------------

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end


  attachment :profile_image, destroy: false

  def self.search(divide_method,word)
    if divide_method == "1"
      users = User.where("name LIKE?", "#{word}")
    elsif divide_method == "2"
      users = User.where("name LIKE?", "#{word}%")
    elsif divide_method == "3"
      users = User.where("name LIKE?", "%#{word}")
    elsif divide_method == "4"
      users = User.where("name LIKE?", "%#{word}%")
    else
      users = User.all
    end
  end

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length: { maximum: 50 }
end
