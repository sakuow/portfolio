class CreateTagnames < ActiveRecord::Migration[5.2]
  def change
    create_table :tagnames do |t|
      t.string :tag_name

      t.timestamps
    end
  end
end
