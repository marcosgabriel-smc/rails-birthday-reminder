class AddShareableTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :shareable_token, :string
  end
end
