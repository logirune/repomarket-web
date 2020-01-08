class AddDemoUrlsToProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :demo_link, :string
    add_column :products, :demo_instruction, :text
    add_column :products, :demo_frontend_url, :string
    add_column :products, :demo_backend_url, :string
  end
end
