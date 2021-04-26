class AddCheckoutToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :checkout_id, :string
  end
end
