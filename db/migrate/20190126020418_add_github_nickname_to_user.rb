class AddGithubNicknameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :github_login, :string
  end
end
