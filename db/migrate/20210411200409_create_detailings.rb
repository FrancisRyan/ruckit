class CreateDetailings < ActiveRecord::Migration[6.0]
  def change
    create_table :detailings do |t|
      t.string :title
      t.text :description
      t.integer :match_time
      t.integer :age
      t.integer :detailing_type
      t.references :fixture, foreign_key: true

      t.timestamps
    end
  end
end
