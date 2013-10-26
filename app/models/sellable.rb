class Service < ActiveRecord::Base
  attr_accessible :data, :name
  
  belongs_to :place
  
  # This hack is buggy. Adds unrequired data fields.
  serialize :data, ActiveRecord::Coders::Hstore
  
  # Do data validations....validate 'data' column
  validates :place_id, presence: true
  validates :name, presence: true, length: { maximum: 500 }
  
  def as_json(options = {})
    {:name => name, :data => data}
  end
end
