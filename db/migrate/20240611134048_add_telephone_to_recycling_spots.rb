class AddTelephoneToRecyclingSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :recycling_spots, :telephone, :string
  end
end
