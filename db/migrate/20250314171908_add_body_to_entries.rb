class AddBodyToEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :entries, :body, :text
  end
end
