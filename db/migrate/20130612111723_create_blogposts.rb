class CreateBlogposts < ActiveRecord::Migration
  def change
    create_table :blogposts do |t|
      t.string :title
      t.string :tags
      t.text :content
      t.image_file :image
      

      t.timestamps
    end
  end
end
