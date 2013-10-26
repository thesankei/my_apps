class Review < ActiveRecord::Base
  attr_accessible :content, :reviewer
  
  belongs_to :place
end
