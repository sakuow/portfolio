class Image < ApplicationRecord
  belongs_to :article
  # 下記は画像を保存するカラム
  attachment :file
end
