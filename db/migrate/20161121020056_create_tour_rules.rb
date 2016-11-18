class CreateTourRules < ActiveRecord::Migration[5.0]
  def change
    create_table :tour_rules do |t|
      t.string :name
      t.integer :amount
      t.integer :type_cal
      t.datetime :start_day
      t.datetime :end_day
      t.timestamps
    end
  end
end
