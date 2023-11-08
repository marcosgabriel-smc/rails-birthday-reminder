class AddTelegramToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :telegram_id, :string
  end
end
