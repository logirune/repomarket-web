class AddFieldsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :net_amount, :decimal, :precision => 15, :scale => 2, :default => 0
    add_column :orders, :fees_amount, :decimal, :precision => 15, :scale => 2, :default => 0
    add_column :orders, :fee_percentage, :integer, :default => 15
  end
end
