class Admin::ProjectsController < ApplicationController
  load_and_authorize_resource
  layout "admin"
  before_filter :get_product, :only => [:edit, :update, :destroy]
  before_filter :pre_load, :only => [:new, :edit]

  def index
    respond_to do |format|
      format.html
      format.json { render json: ProjectDatatable.new(view_context) }
    end
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to admin_projects_path, notice: 'Project was successfully Created' }
        format.json { render json: @project, status: :created, location: [@project] }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update_attributes(project_params)
        format.html { redirect_to admin_projects_path, notice: 'Project successfully Updated' }
        format.json { render json: @project, status: :updated, location: [@project] }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @project.destroy
    redirect_to admin_projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :process_line, :effective_date, :expected_end_date, :meeting_time, :remarks)
  end

  def get_product
    @project = Project.where(:id => params[:id]).last
  end

  def pre_load
    @process_lines = ["BMR", "Design" "Implementation", "Testing", "Go-Live Maintenance"]
  end
end
