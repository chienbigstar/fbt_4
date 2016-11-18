class CreateConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :conditions do |t|
      t.references :tour_rule
      t.string :typed
      t.string :valued
      t.timestamps
    end
  end
end
