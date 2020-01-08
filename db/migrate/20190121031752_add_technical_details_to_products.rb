class AddTechnicalDetailsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :ruby_version, :string, default: nil
    add_column :products, :rails_version, :string, default: nil
    add_column :products, :is_approved, :boolean, default: false
    add_column :products, :is_active, :boolean, default: false
  end
end
