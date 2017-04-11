class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.string :debt_report
      t.string :status, default: :waiting

      t.timestamps
    end
  end
end
