class AddStripeUserIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :stripe_user_id, :string
    add_column :users, :stripe_publishable_key, :string
  end
end
