class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :outlet_id
      t.integer :inlet_id

      t.timestamps
    end
    
    add_index :relationships, outlet_id
    add_index :relationships, inlet_id
    add_index :relationships, [outlet_id, inlet_id], unique: true
  end
end
