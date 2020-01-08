class AddSlugToProductSubtype < ActiveRecord::Migration[6.0]
  def change
    add_column :product_subtypes, :slug, :string
  end
end
