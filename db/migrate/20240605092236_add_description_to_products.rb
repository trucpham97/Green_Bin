class AddDescriptionToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :description, :string
  end
end
