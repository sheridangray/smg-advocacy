class AddTokenToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :token, :string
    add_column :users, :token_expires_at, :datetime
  end
end
