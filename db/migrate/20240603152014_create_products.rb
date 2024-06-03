class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :material
      t.string :name
      t.integer :score
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
