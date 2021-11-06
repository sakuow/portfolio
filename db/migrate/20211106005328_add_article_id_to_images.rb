class AddArticleIdToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :article_id, :integer
  end
end
