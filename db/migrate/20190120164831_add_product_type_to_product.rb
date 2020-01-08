class AddProductTypeToProduct < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :product_type, foreign_key: true
  end
end
