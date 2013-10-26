class CreateServices < ActiveRecord::Migration
  def change
    create_table services do |t|
      t.string :name
      t.hstore :data
      t.references :place

      t.timestamps
    end
    add_index services, :place_id
    add_hstore_index services, :data
  end
end
