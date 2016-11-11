class CreateToursDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :tours_discounts do |t|
      t.references :tour, foreign_key: true
      t.references :discount, foreign_key: true

      t.timestamps
    end
  end
end
