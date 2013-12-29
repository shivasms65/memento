class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  #def after_sign_out_path_for(resource_or_scope)
  #  # If it's admin
  #  if is_admin?(current_user)
  #    admin_path
  #    # Otherwise
  #  else
  #    root_path
  #  end
  #end
end
