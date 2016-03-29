class ChangeTokenTokenToKey < ActiveRecord::Migration
  def change
  	rename_column :tokens, :token, :key
  end
end
