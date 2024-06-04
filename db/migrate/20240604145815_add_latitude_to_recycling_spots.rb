class AddLatitudeToRecyclingSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :recycling_spots, :latitude, :float
  end
end
