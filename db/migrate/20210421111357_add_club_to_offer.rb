class AddClubToOffer < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :club, :string
  end
end
