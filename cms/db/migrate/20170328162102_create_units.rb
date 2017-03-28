class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :number, null: false
      t.string :building_name, null: false
      t.references :condo, index: true, null: false
      t.references :tenant, index: true

      t.timestamps
    end
  end
end
