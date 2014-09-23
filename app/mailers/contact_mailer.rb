class ContactMailer < ActionMailer::Base
  default from: "admin@mementotechnologies.com"

  def invoice_to_contacts(to_list, subject, body, file)
    attachments['invoice.pdf'] = File.read(file.path)
    mail(to: to_list, subject: subject, body: body)
  end
end
