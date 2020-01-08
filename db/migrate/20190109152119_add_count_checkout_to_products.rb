class AddCountCheckoutToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :checkouts_count, :integer, default: 0
  end
end
