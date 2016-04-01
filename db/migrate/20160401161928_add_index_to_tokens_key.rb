class AddIndexToTokensKey < ActiveRecord::Migration
  def change
  	add_index :tokens, :key, unique: true
  end
end
