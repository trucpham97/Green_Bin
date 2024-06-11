class AddSubheadingToRecyclingPointsInfo < ActiveRecord::Migration[7.1]
  def change
    add_column :recycling_point_infos, :subheading, :string
  end
end
