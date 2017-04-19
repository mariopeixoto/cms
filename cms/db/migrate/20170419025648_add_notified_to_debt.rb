class AddNotifiedToDebt < ActiveRecord::Migration
  def change
    add_column :debts, :notified, :boolean, default: false
    remove_column :debts, :notice_id
  end
end
