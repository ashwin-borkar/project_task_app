class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  def index
    @projects = Project.page(params[:page]).per(10)
  end

  def new
     @project = Project.new
     @tasks = @project.tasks.build
   end
 
  def create
   @project = Project.new(project_params)
   if @project.save
     redirect_to projects_path
   else
     render action: :new
   end
  end

  def edit
   
  end
 
  def show
   @project = Project.find(params[:id])
   @tasks = @project.tasks
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  
 
  private
 
  def project_params
    params.require(:project).permit(:name, tasks_attributes: [:id, :name, :_destroy])
  end

  def set_project
    @project = Project.find(params[:id])
  end

end
