class AddDownloadCountToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :downloads_count, :integer, default: 0
  end
end
