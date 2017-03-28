class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :contact_name
      t.string :contact_phone
      t.text :address
      t.float :default_fine, default: 2.0
      t.float :default_interest, default: 1.0

      t.timestamps
    end
  end
end
