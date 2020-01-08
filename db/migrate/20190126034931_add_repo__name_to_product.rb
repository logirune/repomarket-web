class AddRepoNameToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :github_repo_name, :string
  end
end
