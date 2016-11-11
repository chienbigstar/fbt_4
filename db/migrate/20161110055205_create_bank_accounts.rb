class CreateBankAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_accounts do |t|
      t.string :username
      t.string :password_digest
      t.integer :balance
      t.string :accountnumber
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
