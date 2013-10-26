class RemoveTagsFromBlogposts < ActiveRecord::Migration
  def up
    remove_column :blogposts, :tags
  end

  def down
    add_column :blogposts, :tags, :string
  end
end
