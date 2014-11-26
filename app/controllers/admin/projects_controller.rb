class Admin::ProjectsController < ApplicationController
  load_and_authorize_resource
  layout "admin"
  before_filter :get_product, :only => [:edit, :update, :destroy]
  before_filter :pre_load, :only => [:new, :edit, :create]

  def index
    @projects = Project.all
    respond_to do |format|
      format.html
      format.json { render json: ProjectDatatable.new(view_context) }
    end
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to @redirect_path, notice: 'Project was successfully Created' }
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
        format.html { redirect_to @redirect_path, notice: 'Project successfully Updated' }
        format.json { render json: @project, status: :updated, location: [@project] }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @project.destroy
    redirect_to @redirect_path
  end

  def project_inline
    @responses = true
    respond_to do |format|
      format.html
      format.json { render json: ProjectInlineDatatable.new(view_context) }
    end
  end

  private

  def project_params
    responsibilities = params[:project][:responsibilities]
    if responsibilities.is_a?(Array)
      params[:project][:responsibilities] = responsibilities.delete_if {|email| email.blank?}.join(",")
    else
      params[:project][:responsibilities] = responsibilities.split(",").delete_if {|email| email.blank?}.join(",")
    end

    params.require(:project).permit(:name, :process_line, :effective_date, :expected_end_date, :meeting_time, :remarks, :mng_responses, :responsibilities)
  end

  def get_product
    @redirect_path = params[:redirect_path].to_s == "project_inline_admin_projects_path" ? project_inline_admin_projects_path : admin_projects_path
    @project = Project.where(:id => params[:id]).last
  end

  def pre_load
    @redirect_path = params[:redirect_path].to_s == "project_inline_admin_projects_path" ? project_inline_admin_projects_path : admin_projects_path
    @process_lines = ["BMR", "Design" "Implementation", "Testing", "Go-Live Maintenance"]
    @users = User.pluck(:email)
    @users = @users.select {|u|  [u, u]}
  end
end
