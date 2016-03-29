class AddPasswordDigestToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :password_digest, :string
  end
end
