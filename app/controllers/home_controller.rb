class HomeController < ApplicationController
  #load_and_authorize_resource
  before_filter :authenticate_user!, :except => [:about, :careers, :contact]
  
  layout :user_or_admin_layout, :except => [:about, :careers, :contact]
  
  def index
    @micropost = current_user.microposts.build 
    @feed_items = current_user.feed.paginate(page: params[:page])
  end
  
  def about
  end
  
  def careers
  end
  
  def developer
  end
  
  def contact
  end
end
