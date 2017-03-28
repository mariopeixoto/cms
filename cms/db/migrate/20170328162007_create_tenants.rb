class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name, null: false
      t.text :billing_address, null: false
      t.string :ssn, null: false
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end
