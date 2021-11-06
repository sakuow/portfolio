class AddArticleIdToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :article_id, :integer
  end
end
