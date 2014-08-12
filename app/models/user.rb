class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  ROLES = %w[Admin Moderator Author Banned]

  def admin?
    self.role == "Admin"
  end

  def moderator?
    self.role == "Moderator"
  end

  def author?
    self.role == "Author"
  end

  def banned?
    self.role == "Banned"
  end

end
