class CoursesController < ApplicationController
  protect_from_forgery except: [:payment_notification]
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @tasks = @course.tasks
  end

  def subscribe
    @course = Course.find(params[:id])
    @subscription = Subscription.find_or_create_by(user: current_user, course_id: params[:id])

    if @subscription.active?
      redirect_to my_courses_path
    else
      values = {
        :business => "dwindy.stanza-facilitator@outlook.com",
        :cmd => "_xclick",
        :upload => 1,
        :amount => @course.price,
        :notify_url => "https://3b7a3539.ngrok.io/payment_notification",
        :item_name => @course.title,
        :item_number => @subscription.id,
        :quantity => 1,
        :return => "https://3b7a3539.ngrok.io/my_courses"
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
    @subscription.update_attributes({active: true})
    respond_to do |format|
      format.html {render text: "ok"}
    end
  end
end
