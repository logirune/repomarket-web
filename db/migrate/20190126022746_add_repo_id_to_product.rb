class AddRepoIdToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :github_repo_id, :string
    add_column :products, :github_repo_language, :string
    add_column :products, :github_repo_type, :string
  end
end
