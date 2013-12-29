class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  ROLES = %w[admin moderator author banned]

  def role?(base_role)
    return self.role == base_role.to_s
  end
end
