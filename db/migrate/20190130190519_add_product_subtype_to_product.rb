class AddProductSubtypeToProduct < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :product_subtype, foreign_key: true
  end
end
