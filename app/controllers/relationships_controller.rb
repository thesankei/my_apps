class RelationshipsController < ApplicationController
  before_filter :signed_in_user
  
  def create
    @user = User.find(params[:relationship][included_id])
    current_user.include!(@user)
    
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
  def destroy
    @user = Relationship.find(params[:id]).included
    current_user.exclude!(@user)
    
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end