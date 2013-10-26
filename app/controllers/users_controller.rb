class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user,only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def following
    @title = "INCLUDED"
    @user = User.find(params[:id])
    @users = @user.included_users.paginate(page: params[:page])
    render 'show_include'
  end
  
  def outlets
    @title = "Outlets"
    @user = User.find(params[:id])
    @users = @user.outlets.paginate(page: params[:page])
    render 'show_include'
  end
end
