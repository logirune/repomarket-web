class AddStripeResponseDataToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :stripe_response_data, :json, default: {}
  end
end
