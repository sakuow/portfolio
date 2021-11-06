class RemoveTagNameFromTags < ActiveRecord::Migration[5.2]
  def change
    remove_column :tags, :tag_name, :string
  end
end
