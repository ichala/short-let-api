class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :admin, index: true, foreign_key: { to_table: :users }
      t.references :recipient, index: true, foreign_key: { to_table: :users }
      t.text :text
      t.references :reserve, index: true, foreign_key: { to_table: :reservations }
      t.timestamps
    end
  end
end
