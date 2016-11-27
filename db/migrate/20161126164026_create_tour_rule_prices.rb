class CreateTourRulePrices < ActiveRecord::Migration[5.0]
  def change
    create_table :tour_rule_prices do |t|
      t.references :tour_rule
      t.references :tour
      t.date :day
      t.integer :price
      t.timestamps
    end
  end
end
