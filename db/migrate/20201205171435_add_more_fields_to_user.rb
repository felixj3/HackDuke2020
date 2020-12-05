class AddMoreFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email, :string
    add_column :users, :clubs, :string # can't have a list of clubs
  end
end
