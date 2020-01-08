class AddPurchaseCountToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :purchases_count, :integer, default: 0
  end
end
