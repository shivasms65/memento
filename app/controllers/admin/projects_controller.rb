class Admin::ProjectsController < ApplicationController
  load_and_authorize_resource
  layout "admin"

  def index
    respond_to do |format|
      format.html
      format.json { render json: ProjectDatatable.new(view_context) }
    end
  end

  def new
    @process_lines = ["BMR", "Design" "Implementation", "Testing", "Go-Live Maintenance"]
  end
end
