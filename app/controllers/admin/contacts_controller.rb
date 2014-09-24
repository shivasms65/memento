class Admin::ContactsController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:new, :create]
  before_filter :authenticate_user!
  before_filter :get_contacts
  before_filter :define_arrays_for_form, :except => [:index, :destroy]
  layout "admin"

  def index
    respond_to do |format|
      format.html
      format.json { render json: ContactDatatable.new(view_context) }
    end
  end

  def new
    @contact = Contact.new
    @type_of_organizations = Contact.select("distinct type_of_organization").map(&:type_of_organization).compact
    @type_of_organizations << "Others"
    @price_ranges = ["0-30k", "30k-60k", "60k-90k", "90k>"]

    # render :layout => false
  end

  def create
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.save
        format.html { redirect_to new_admin_contact_path, notice: 'You have successfully Contacted Us We will get back you soon.' }
        format.json { render json: @contact, status: :created, location: [@contact] }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @contact = Contact.where(:id => params[:id]).last
  end

  def update
    @contact = Contact.where(:id => params[:id]).last

    respond_to do |format|
      if @contact.update_attributes(contact_params)
        format.html { redirect_to admin_contacts_path, notice: 'You have successfully Updated' }
        format.json { render json: @contact, status: :updated, location: [@contact] }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact = Contact.where(id: params[:id]).first
    @contact.destroy
    redirect_to admin_contacts_path
  end

  def send_mail_form
    @process_lines = ["New", "Pipeline", "Potential", "Observed", "Consumer"]
  end

  def send_mail_to_contacts
    mailer = sent_mail_params
    to_list = Contact.where(:process_line => mailer[:process_line]).map(&:email)
    # to_list = ["shiva.sms65@gmail.com", "genetech003@gmail.com"] if Rails.env == "development" # TODO have to remove
    Contact.send_mails_to_contacts(to_list, mailer[:subject], mailer[:body], mailer[:file])
    if to_list.blank?
      flash[:error] = "No Contacts in Process Line is '#{mailer[:process_line]}'"
    else
      flash[:notice] = "Successfully Sent Mails to Contacts for Process Line is '#{mailer[:process_line]}'"
    end
    redirect_to send_mail_form_admin_contacts_path
  end

  private

  def get_contacts
    @contacts = Contact.last(3).reverse
  end

  def sent_mail_params
    params.require(:mailer).permit(:subject, :body, :file, :process_line)
  end

  def contact_params
    if params[:contact][:type_of_organization] == "Others"
      params[:contact][:type_of_organization] = params[:new_type_of_organization]
    end
    params.require(:contact).permit(:name, :email, :mobile, :note, :organization_name, :type_of_service, :exp_price_range, :type_of_organization, :service_convinced, :process_line, :remarks)
  end

  def define_arrays_for_form
    @type_of_organizations = Contact.select("distinct type_of_organization").map(&:type_of_organization).compact
    @type_of_organizations << "Others"
    @price_ranges = ["0-30k", "30k-60k", "60k-90k", "90k>"]
    @pipelines = ["New", "Pipeline", "Potential", "Observed", "Consumer"]
  end
end
