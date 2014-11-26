class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  layout 'admin'
  #before_filter :authenticate_user!
  # before_filter do
  #   redirect_to :new_user_session_path if (current_user.blank? || !current_user.admin?)
  # end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_url, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: [:admin,@user] }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.where(id: params[:id]).first
  end

  def update
    @user = User.where(id: params[:id]).first
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to admin_users_url, notice: 'User was successfully updated.' }
        format.json { render json: @user, status: :created, location: [:admin,@user] }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.where(id: params[:id]).first
    @user.destroy
    redirect_to admin_users_path
  end

  def show
    p @user = User.where(id: params[:id]).first
    p @user_attributes = @user.attributes
    @user_attributes.delete_if {|k,v| ["reset_password_token", "encrypted_password", "unlock_token"].include?(k)}
    p @user_attributes
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

end
