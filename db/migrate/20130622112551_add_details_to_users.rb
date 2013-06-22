class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lurl, :string
    add_column :users, :location, :string
    add_column :users, :img, :string
    add_column :users, :coins, :integer , :default => 300
    add_column :users, :portlink, :string
    add_column :users, :successrate, :real
  end
end
