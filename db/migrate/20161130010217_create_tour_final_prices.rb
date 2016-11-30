class CreateTourFinalPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :tour_final_prices do |t|
      t.references :tour
      t.references :tour_rule_price
      t.integer :price
      t.timestamps
    end
  end
end
