class AddNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :text
    add_column :users, :dob, :date
  end
end
