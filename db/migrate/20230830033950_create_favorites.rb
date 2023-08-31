class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.integer :facility_id, foreign_key: true, null: false

      t.timestamps
    end
  end
end
