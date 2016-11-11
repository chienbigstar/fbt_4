class CreateDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :discounts do |t|
      t.integer :percent
      t.datetime :start_date
      t.datetime :end_date
      t.string :title
      t.integer :status
      t.references :tour, foreign_key: true

      t.timestamps
    end
  end
end
