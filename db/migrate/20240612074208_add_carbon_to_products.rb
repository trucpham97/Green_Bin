class AddCarbonToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :carbon, :integer
  end
end
