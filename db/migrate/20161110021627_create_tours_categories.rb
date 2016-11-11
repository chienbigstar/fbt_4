class CreateToursCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :tours_categories do |t|
      t.references :tour, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
