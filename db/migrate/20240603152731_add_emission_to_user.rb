class AddEmissionToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :emission, :float
  end
end
