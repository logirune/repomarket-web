class AddFieldsToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :features, :text
    add_column :products, :demo_link, :string
  end
end
