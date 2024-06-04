class AddLongitudeToRecyclingSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :recycling_spots, :longitude, :float
  end
end
