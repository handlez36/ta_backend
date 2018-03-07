class ChangeDescriptionInCategory < ActiveRecord::Migration[5.0]
  def change
    change_column :categories, :description, :text
  end
end
