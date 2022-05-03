class AddUserToWritings < ActiveRecord::Migration[7.0]
  def change
    add_reference :writings, :user, null: false, foreign_key: true
  end
end
