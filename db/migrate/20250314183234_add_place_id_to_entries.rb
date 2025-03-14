class AddPlaceIdToEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :entries, :place_id, :integer
  end
end
