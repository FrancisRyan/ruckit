class AddRequestToChallenge < ActiveRecord::Migration[6.0]
  def change
    add_reference :challenges, :request, null: true, foreign_key: true
  end
end
