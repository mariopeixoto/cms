class CreateCondos < ActiveRecord::Migration
  def change
    create_table :condos do |t|
      t.string :name, null: false
      t.text :address
      t.references :client, index: true, null: false

      t.timestamps
    end

    add_foreign_key :condos, :clients
  end
end
