class AddAuthorIdInOrders < ActiveRecord::Migration[6.0]
  def change
      add_column :orders, :author_id, :bigint, foreign_key: true
  end
end
