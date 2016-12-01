class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :total_money
      t.boolean :is_pay
      t.integer :number_member
      t.references :user, foreign_key: true
      t.references :tour, foreign_key: true
      t.references :discount
      t.string :payment_token
      t.integer :status, default: 0
      t.integer :discount_money
      t.string :contact_email
      t.string :phone_number

      t.timestamps
    end
  end
end
