class Admin::FinancesController < ApplicationController
  load_and_authorize_resource
  before_filter :get_finance, :only => [:edit, :destroy]
  before_filter :pre_load, :only => [:new, :edit]
  layout 'admin'

  def index
    @capital = Capital.get_overall_values()
    respond_to do |format|
      format.html
      # format.json { render json: InflowDatatable.new(view_context) }
    end
  end

  def inflow
    respond_to do |format|
      format.html
      format.json { render json: InflowDatatable.new(view_context) }
    end
  end

  def outflow
    respond_to do |format|
      format.html
      format.json { render json: OutflowDatatable.new(view_context) }
    end
  end

  def create
    @finance = Finance.new(finance_params)
    respond_to do |format|
      if @finance.save
        format.html { redirect_to admin_finances_path, notice: 'Finance was successfully Created' }
        format.json { render json: @finance, status: :created, location: [@finance] }
      else
        format.html { render action: "new" }
        format.json { render json: @finance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @finance.update_attributes(finance_update_params)
        format.html { redirect_to admin_finances_path, notice: 'Finance was successfully Updated' }
        format.json { render json: @finance, status: :created, location: [@finance] }
      else
        format.html { render action: "edit" }
        format.json { render json: @finance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @finance.destroy
    redirect_to admin_finances_path
  end

  def capital
    respond_to do |format|
      format.html
      format.json { render json: CapitalDatatable.new(view_context) }
    end
  end

  private

  def finance_params
    params.require(:finance).permit(:process_date, :particulars, :amount, :remarks, :type)
  end

  def finance_update_params
    require_type = params[:type].to_s.downcase ||= :finance
    params.require(require_type).permit(:process_date, :particulars, :amount, :remarks)
  end

  def pre_load
    params[:type] ||= "Inflow"
    @types = ["Inflow", "Outflow", "Capital"]
  end

  def get_finance
    @finance = Finance.where(:id => params[:id]).last
    params[:type] ||= @finance.type unless @finance.blank?
  end
end
