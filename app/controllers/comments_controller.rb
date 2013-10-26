class CommentsController < ApplicationController
  def create
    @blogpost = Blogpost.find(params[:blogpost_id])
    @comment = @blogpost.comments.create(params[:comment])
    redirect_to blogpost_path(@blogpost)
  end
  
  def destroy
    @blogpost = Blogpost.find(params[:blogpost_id])
    @comment = @blogpost.comments.find(params[:id])
    @comment.destroy
    redirect_to blogpost_path(@blogpost)
  end
end
