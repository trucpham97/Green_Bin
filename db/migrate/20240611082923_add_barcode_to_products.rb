class AddBarcodeToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :barcode, :string
  end
end
