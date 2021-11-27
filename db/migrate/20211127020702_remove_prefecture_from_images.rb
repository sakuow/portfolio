class RemovePrefectureFromImages < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :prefecture, :string
  end
end
