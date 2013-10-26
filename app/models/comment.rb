class Comment < ActiveRecord::Base
  belongs_to :blogpost
  
  attr_accessible :content
  

  validates :content, presence: true, length: { maximum: 500 }
end
