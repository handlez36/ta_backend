class UpdateUserIdToString < ActiveRecord::Migration
  def change
    change_column :journeys, :user_id, :string
  end
end
