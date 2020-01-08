class AddCountViewsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :views_count, :integer, default: 0
  end
end
