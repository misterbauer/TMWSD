class AddIndexToMessagesKey < ActiveRecord::Migration
  def change
  	add_index :messages, :key, unique: true
  end
end
