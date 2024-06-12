class ChangeDefaultForCarbonInProducts < ActiveRecord::Migration[7.1]
  def change
    change_column_default :products, :carbon, 200
  end
end
