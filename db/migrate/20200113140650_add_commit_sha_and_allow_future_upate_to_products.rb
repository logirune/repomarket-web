class AddCommitShaAndAllowFutureUpateToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :commit_sha, :text
    add_column :products, :commit_sha_latest, :text
    add_column :products, :allow_latest_version, :boolean
  end
end
