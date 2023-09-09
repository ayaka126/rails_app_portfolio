class CreateFacilities < ActiveRecord::Migration[7.0]
  def change
    create_table :facilities do |t|
      t.string :name
      t.text :address
      t.text :station
      t.string :tel
      t.string :homepage

      t.timestamps
    end
  end
end
