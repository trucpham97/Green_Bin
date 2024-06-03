class CreateRecyclingSpotTags < ActiveRecord::Migration[7.1]
  def change
    create_table :recycling_spot_tags do |t|
      t.references :recycling_spot, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
