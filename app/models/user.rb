class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  #Bad hack.........................FIX THIS!!!
  if Rails.env.development?
    before_save :setup_role
  elsif Rails.env.production?
    before_save :setup_role
  end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
   
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role_ids,
  :provider, :uid,:current_password
  # attr_accessible :title, :body
  
  
  has_many :microposts, dependent: :destroy
  has_many :blogposts, dependent: :destroy
  has_many :places, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: "followed" #should be _id
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
                                   
  has_many :followers, through: :reverse_relationships, source: :follower
  has_and_belongs_to_many :roles
  
  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  # Default role is "Member"
  def setup_role 
    if self.role_ids.empty?     
      self.role_ids = [2] 
    end
  end
  
  #Gets current user activity feed.
  def feed
    Micropost.from_users_followed_by(self)
  end
  #Gets the facebook authentication and images to the user, once they are signed in via facebook
  #def rails generate migration 
   # addImageToUsers
   # image: string
 # end
  
  #Gets current user blogpost feed.
  def blog_feed
    Blogpost.from_users_followed_by(self)
  end
  
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end
  
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
