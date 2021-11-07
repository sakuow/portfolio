class Image < ApplicationRecord
  belongs_to :article
  # 下記は画像を保存するカラム
  attachment :file
end


# {
#   title: "",
#   body: "",
#   images_attributes: {
#     "0" => {
#       prefecture: "a",
#       file: "",
#     },
#     "1" =>  {
#       prefecture: "a",
#       file: "",
#     }
#   }
# }

# {
#   title: "",
#   body: "",
#   images_attributes: {
#     "0" => {
#       prefecture: "a",
#       file: ["", ""],
#     },
#   }
# }
