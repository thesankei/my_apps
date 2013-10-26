class Place < ActiveRecord::Base
  attr_accessible :data, :description, :location, :name
    
  belongs_to :user
  
  has_many :services, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  # Do data validations....validate 'data'
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 5000 }
  validates :location, presence: true, length: { maximum: 500 }
  validates :name, presence: true, length: { maximum: 500 }
end
