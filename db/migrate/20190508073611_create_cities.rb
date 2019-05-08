class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :parent_id, index: true
      t.string :name, null: false
      t.string :url
      t.integer :area_num

      t.timestamps
    end
  end
end
