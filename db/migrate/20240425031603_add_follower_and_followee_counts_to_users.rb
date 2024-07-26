class AddFollowerAndFolloweeCountsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :followers_count, :integer
    add_column :users, :followees_count, :integer
  end
end
