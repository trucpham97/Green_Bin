class ChangePackagingToArrayInRecyclingPointInfos < ActiveRecord::Migration[7.1]
  def change
    change_column :recycling_point_infos, :packaging, :string, array: true, default: [], using: "(string_to_array(packaging, ','))"
  end
end
