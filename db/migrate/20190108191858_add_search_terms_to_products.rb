class AddSearchTermsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :search_terms, :string
  end
end
