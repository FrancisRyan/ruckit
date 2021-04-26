class CreateChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :challenges, id: :uuid do |t|
      t.date :due_date
      t.string :title
      t.integer :status, default: 0
      t.string :creator_name
      t.string :challenger_name
      t.references :fixture, null: true, foreign_key: true
      t.references :challenger, references: :users, foreign_key: { to_table: :users}
      t.references :creator, references: :users, foreign_key: { to_table: :users}

      t.timestamps
    end
  end
end
   
     