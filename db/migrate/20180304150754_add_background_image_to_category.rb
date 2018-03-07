class AddBackgroundImageToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :bg_image, :string
  end
end
