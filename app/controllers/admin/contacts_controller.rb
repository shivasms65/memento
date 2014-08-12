class Admin::ContactsController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:new, :create]
  before_filter :authenticate_user!
  before_filter :get_contacts
  layout "admin"

  def index
    respond_to do |format|
      format.html
      format.json { render json: ContactDatatable.new(view_context) }
    end
  end

  def new
    @contact = Contact.new
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

  def destroy
    @contact = Contact.where(id: params[:id]).first
    @contact.destroy
    redirect_to admin_contacts_path
  end

  private

  def get_contacts
    @contacts = Contact.last(3).reverse
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :mobile, :note)
  end

end
