class AddViewsToDocument < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :views, :integer, default: 0, null: false
  end
end
