class TasksController < ApplicationController
    before_action :set_up_list
    before_action :set_up_task, except: [:create]

    def create
        # Creates a task on current list
        @task = @list.tasks.create(task_params)

        # Redirects to current list
        redirect_to @list
    end

    def destroy
      if @task.destroy
        flash[:success] = "Task was deleted"
      else
        flash[:success] = "Task could not be deleted"
      end
      redirect_to @list
    end

    def complete
      @task.update_attribute(:completed_at, Time.now)
      redirect_to @list, notice: "Task completed!"
    end

    private

    def set_up_list
        # Finds a list you're on
        @list = List.find(params[:list_id])
    end

    def set_up_task
        # Finds task
        @task = @list.tasks.find(params[:id])
    end

    def task_params
        # Rails required strong parameters
        params.require(:task).permit(:content)
    end
end
