class CreateFixtures < ActiveRecord::Migration[6.0]
  def change
    create_table :fixtures do |t|
      t.string :title
      t.string :video
      t.boolean :active, default: false
      t.boolean :has_single_detailing, default: false
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end