class Tag < ApplicationRecord
    belongs_to :article
    belongs_to :tagname
end
