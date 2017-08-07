class CoursesController < ApplicationController
  protect_from_forgery except: [:payment_notification]
  before_action :authenticate_user!, only: [:subscribe, :my_courses]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.friendly.find(params[:id])
    @tasks = @course.tasks
    @review = Review.new(course_id: @course.id, user_id: current_user.id) if user_signed_in?
    @reviews = @course.reviews
end

  def subscribe
    @course = Course.friendly.find(params[:id])
    @subscription = Subscription.find_or_create_by(user: current_user, course_id: @course.id)

    if @subscription.active?
      redirect_to my_courses_path
    else
      values = {
        :business => "dwindy.stanza-facilitator@outlook.com",
        :cmd => "_xclick",
        :upload => 1,
        :amount => @course.price,
        :notify_url => "http://24485205.ngrok.io/payment_notification",
        :item_name => @course.title,
        :item_number => @subscription.id,
        :quantity => 1,
        :return => "http://24485205.ngrok.io"
      }
      redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
    end
  end

  def my_courses
    @courses = current_user.courses
  end

  def payment_notification
    params.permit!
    @subscription = Subscription.find(params[:item_number])
    if @subscription.active == false && params[:payment_status] == "Completed"
      if @subscription.update_attributes({active: true, payment_status: "Completed"})
        PaymentMailer.payment_completed(@subscription).deliver
      end
    end

    respond_to do |format|
      format.html {render text: "ok"}
    end
  end
end
