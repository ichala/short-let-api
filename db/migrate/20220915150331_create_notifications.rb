class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :id
      t.integer :recipient_id
      t.integer :admin_id
      t.text :text
      t.integer :reserve_id

      t.timestamps
    end
  end
end
