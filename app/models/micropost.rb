class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  
  default_scope order: 'microposts.created_at DESC'
  
  validates :content, presence: true, length: { maximum: 300 }
  validates :user_id, presence: true
  
  # Returns microposts from the users being followed by the given user.
  # Uses SQL subselects to do efficient feed retrieval.
  def self.from_users_included_by(user)
    included_user_ids = "SELECT inlcuded_id FROM relationships
                          WHERE outlet_id = :user_id"
    where("user_id IN (#{included_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
