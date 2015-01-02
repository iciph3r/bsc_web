class AddBscToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bsc, :boolean, default: false
  end
end
