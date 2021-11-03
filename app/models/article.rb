class Article < ApplicationRecord
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # タグとのアソシエーション記載する
  accepts_nested_attributes_for :images
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
end
