class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :make, null: false
      t.string :model, null: false
      t.integer :year, null: false
      t.integer :mileage, null: false
      t.float :price, null: false
      t.string :exterior_color, null: false
      t.string :interior_color, null: false
      t.boolean :runs, default: true
      t.text :upgrades, array: true

      t.timestamps
    end
  end
end
