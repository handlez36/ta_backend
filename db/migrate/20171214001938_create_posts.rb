class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text   :content
      t.string :video_url
      t.string :image_urls, array: true, default: []
      t.integer :journey_id, null: false
      
      t.timestamps null: false
    end
  end
end
