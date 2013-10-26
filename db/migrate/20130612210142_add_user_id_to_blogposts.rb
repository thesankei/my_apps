class AddUserIdToBlogposts < ActiveRecord::Migration
  def change
    add_column :blogposts, :user_id, :integer
    
    add_index "blogposts", ["user_id", "created_at"], :name => "index_blogposts_on_user_id_and_created_at"
  end
  
  
end
