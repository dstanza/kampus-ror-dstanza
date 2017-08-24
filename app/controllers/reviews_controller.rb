class ReviewsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def create
    @review = current_user.reviews.new(review_params)
    @course = Course.friendly.find(params[:course_id])
    @review.course = @course
    @review.save
    
    respond_to do |format|
      format.html do
        redirect_to @course, notice: "Review succesfully submitted"
      end
      format.js
    end

  end

  def review_params
    params.require(:review).permit(:star, :comment, :course_id, :user_id)
  end

  def destroy
    @review.destroy

    respond_to do |format|
      format.html do
        redirect_to @review.course, notice: "Review succesfully removed"
      end
      format.js
    end
  end
end
