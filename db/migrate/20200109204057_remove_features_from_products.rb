class RemoveFeaturesFromProducts < ActiveRecord::Migration[6.0]
  def change
     remove_column :products, :features, :text
     remove_column :products, :demo_instruction, :text
     remove_column :products, :demo_frontend_url, :string
     remove_column :products, :demo_backend_url, :string
     remove_column :products, :ruby_version, :string
     remove_column :products, :rails_version, :string
  end
end
