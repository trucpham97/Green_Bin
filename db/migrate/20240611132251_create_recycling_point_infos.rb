class CreateRecyclingPointInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :recycling_point_infos do |t|
      t.string :title
      t.string :illustration
      t.string :packaging

      t.timestamps
    end
  end
end
