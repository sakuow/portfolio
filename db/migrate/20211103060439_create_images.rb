class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :prefecture
      t.integer :latitude
      t.integer :longitude

      t.timestamps
    end
  end
end
