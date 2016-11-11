class CreateTours < ActiveRecord::Migration[5.0]
  def change
    create_table :tours do |t|
      t.string :name
      t.date :time_tour
      t.date :start_day
      t.string :start_place
      t.integer :price
      t.text :description
      t.text :schedule
      t.float :avgrate
      t.integer :numberrate
      t.integer :is_active

      t.timestamps
    end
  end
end
