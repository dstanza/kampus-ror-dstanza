class TasksController < ApplicationController

  load_and_authorize_resource :find_by => :slug

  def show
    course = Course.friendly.find(params[:course_id])
    @tasks = course.tasks.accessible_by(current_ability)
    @previous_task = @task.previous_task(@tasks)
    @next_task = @task.next_task(@tasks)
    
  end
end
