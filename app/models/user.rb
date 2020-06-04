class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false
  has_many :favorites, dependent: :destroy

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。

  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end
  # selfにはcurrent_userが入る
end