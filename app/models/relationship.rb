class Relationship < ActiveRecord::Base
  attr_accessible :inlet_id , :outlet_id
  
  belongs_to :outlet, class_name: "User"
  belongs_to :inlet, class_name: "User"
  
  validates :outlet_id, presence: true
  validates :outlet_id, presence: true
end
