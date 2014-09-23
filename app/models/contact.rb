class Contact < ActiveRecord::Base
  validates_presence_of :name, :email, :mobile, :type_of_organization
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}, :if => Proc.new { |contact| !contact.email.blank? }
  validates :mobile, :numericality => true, :if => Proc.new { |contact| !contact.mobile.blank? }
  validates :mobile, :length => { :minimum => 10, :maximum => 15 }, :if => Proc.new { |contact| contact.mobile.to_i != 0 && contact.mobile.to_i.is_a?(Integer) }

  def self.send_mails_to_contacts(to_list, subject, body, file)
    to_list.each do |each_contact|
      ContactMailer.invoice_to_contacts(each_contact, subject, body, file).deliver
    end
  end

end