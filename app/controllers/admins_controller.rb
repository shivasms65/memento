class AdminsController < ApplicationController
  before_filter :authenticate_user!, :except => [:admin]
  layout 'admin'

  def index
    @contacts = Contact.last(3).reverse
  end

  def admin
    if current_user
      redirect_to '/admins'
    else
      redirect_to "/login"
    end
  end
end
