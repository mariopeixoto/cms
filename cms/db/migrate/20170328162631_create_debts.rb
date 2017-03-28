class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.string :description
      t.float :original_amount, null: false
      t.date :due_date, null: false
      t.string :debt_type, null: false
      t.references :unit, index: true, null: false
      t.references :tenant, index: true, null: false
      t.references :notice, index: true

      t.timestamps
    end
  end
end
