class SessionsController < Devise::SessionsController

  layout false
  def new
    super
  end
end
