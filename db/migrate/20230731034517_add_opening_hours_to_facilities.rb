class AddOpeningHoursToFacilities < ActiveRecord::Migration[7.0]
  def change
    add_column :facilities, :opening_hours, :string
  end
end
