class AddDescriptionToTags < ActiveRecord::Migration[7.1]
  def change
    add_column :tags, :description, :string
  end
end
