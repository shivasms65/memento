class AdminsController < ApplicationController
  before_filter :authenticate_user!, :except => [:admin]
  layout 'admin'

  def index
    @contacts = Contact.last(3)
  end

  def admin
    if current_user
      redirect_to '/admins'
    else
      render "devise/sessions/new"
    end
  end
end
