class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.text :note
      t.integer :age
      t.date :date
      t.integer :status, default:0
      t.references :request, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
