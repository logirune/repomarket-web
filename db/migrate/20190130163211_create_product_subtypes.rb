class CreateProductSubtypes < ActiveRecord::Migration[6.0]
  def change
    create_table :product_subtypes do |t|
      t.string :name
      t.references :product_type, foreign_key: true

      t.timestamps
    end
  end
end
