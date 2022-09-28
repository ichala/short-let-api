class CreateHalls < ActiveRecord::Migration[7.0]
  def change
    create_table :halls do |t|
      t.string :name
      t.integer :capacity
      t.decimal :cost
      t.string :image
      t.text :description

      t.timestamps
    end
  end
end
