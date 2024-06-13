class AddDefaultValueToUserEmission < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :emission, 0
  end
end
