class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :totalmoney
      t.boolean :is_pay
      t.integer :numbermember
      t.references :user, foreign_key: true
      t.references :tour, foreign_key: true
      t.references :discount

      t.timestamps
    end
  end
end
