class MicropostsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :correct_user, only: :destroy
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    
    if @micropost.save
      #flash[:success] = "Micropost created!"
      redirect_to root_path, :notice => 'Micropost created!'
    else
      @feed_items = [] #hack....change this behaviour
      render 'home/index'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_path
  end
  
  private
  
  #Checks whether the current user actually has the id of the given micropost.
  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_path if @micropost.nil?
  end
end