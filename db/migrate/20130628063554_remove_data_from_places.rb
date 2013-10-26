class RemoveDataFromPlaces < ActiveRecord::Migration
  def up
    remove_column :places, :data
  end

  def down
    add_column :places, :data, :hstore
  end
end
