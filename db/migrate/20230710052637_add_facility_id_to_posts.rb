class AddFacilityIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :facility, null: false, foreign_key: true
  end
end
