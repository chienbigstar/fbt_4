class CreateConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :conditions do |t|
      t.references :tour_rule
      t.integer :condition_type
      t.string :condition_value
      t.timestamps
    end
  end
end
