class UpdateRelationInPost < ActiveRecord::Migration
  def change
    rename_column :posts, :journey_id, :journy_id
  end
end
