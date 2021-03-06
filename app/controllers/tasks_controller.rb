class TasksController < ApplicationController

  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    # Task.methods.each do |single|
      
    #   puts " ------> #{single}"
    # end
    
    @tasks = Task.where(user_id: current_user.id)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    # @task = current_user.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def generate_report
    @users = User.all
  end

  def report
    @id_user = params[:id_user]
    @state = params[:state]
    @tasks = Task.where("user_id = ? AND state = ?",@id_user,@state)
  
    # ACA HAY UN BUUUGASO

    
    # TaskMailer.new_report(@id_user, @state).deliver_later
    respond_to do |format|
   
        format.html 
        format.pdf {render template: 'tasks/mipdf',pdf: 'Reporte'}
        format.json
        format.xlsx {render xlsx: 'Reporteex', template: 'tasks/miexcel'}
      end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:user_id, :name, :detail, :state, :date_start, :date_end, :file)
    end
end
