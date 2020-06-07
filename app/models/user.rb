class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable,:validatable

  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}

  has_many :books, dependent: :destroy
  attachment :profile_image, destroy: false

  # コメント機能
  has_many :book_comments, dependent: :destroy

  # いいね機能
  has_many :favorites, dependent: :destroy


  # フォロー取得
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  # 中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを「following」と定義
  has_many :followings, through: :active_relationships, source: :follower

  # フォロワーの取得
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  # 中間テーブルを介して「following」モデルのUser(フォローする側)を集めることを「followed」と定義
  has_many :followers, through: :passive_relationships, source: :following

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。

  # いいね機能
  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
    # selfにはcurrent_userが入る
  end

  # フォロー済みか判定
  def followed_by?(user)
      passive_relationships.find_by(following_id: user.id).present?
  end

  # フォローを外す機能
  # def unfollow(user_id)
  #   active_relationships.find_by(follower_id: user.id).destroy
  # end

  # フォロー機能
  # def follow(user_id)
  #   active_relationships.create(follower_id: user_id)
  # end

end