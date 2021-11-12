class Article < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy, autosave: true
  accepts_attachments_for :images, attachment: :file
  has_many :favorites, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :tagnames, through: :tags
# いいね順の一覧ページ
  has_many :favorited_users, through: :favorites, source: :user

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end