class ContactsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.save
        format.html { redirect_to new_contact_path, notice: 'You have successfully Contacted Us We will get back you soon.' }
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
    redirect_to admins_contacts_path
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :mobile, :note)
  end

end
