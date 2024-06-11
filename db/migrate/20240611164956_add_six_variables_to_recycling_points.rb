class AddSixVariablesToRecyclingPoints < ActiveRecord::Migration[7.1]
  def change
    add_column :recycling_point_infos, :description_title, :string
    add_column :recycling_point_infos, :descriptions, :string, array: true, default: []
    add_column :recycling_point_infos, :search_terms_hidden, :string, array: true, default: []
    add_column :recycling_point_infos, :we_win, :string
    add_column :recycling_point_infos, :helper, :string
    add_column :recycling_point_infos, :no_no, :string, array: true, default: []
  end
end
