class Project < ActiveRecord::Base
  after_save :send_mail_to_responsible_users

  private

  def send_mail_to_responsible_users
    users = self.responsibilities.to_s
    if !users.blank?
      users = users.split(",")
      # to_list = ["shiva.sms65@gmail.com", "genetech003@gmail.com"] if Rails.env == "development" # TODO have to remove
      users.each do |each_user|
        ProjectMailer.responsibility_alert(each_user, self).deliver
      end
    end
  end
end
