class CreateRecyclingSpots < ActiveRecord::Migration[7.1]
  def change
    create_table :recycling_spots do |t|
      t.string :category
      t.string :address

      t.timestamps
    end
  end
end
