class ReviewsController < ApplicationController
  def create
    @place = Place.find(params[:place_id])
    params[:review][:reviewer] = current_user.name
    @comment = @place.reviews.create(params[:review])
    redirect_to place_path(@place)
  end
  
  def destroy
    @place = Place.find(params[:place_id])
    @comment = @place.reviews.find(params[:id])
    @comment.destroy
    redirect_to place_path(@place)
  end
end
