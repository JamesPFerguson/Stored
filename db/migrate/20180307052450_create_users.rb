class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    t.string :username
    t.string :email
    t.string :password_digest
  end
end
