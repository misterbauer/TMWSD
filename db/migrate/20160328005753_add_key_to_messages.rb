class AddKeyToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :key, :string
  end
end
