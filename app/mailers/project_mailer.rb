class ProjectMailer < ActionMailer::Base
  default from: "admin@mementotechnologies.com"

  def responsibility_alert(to_list, project)
    subject = "Responsiblility Alert for Project #{project.name}"
    body = "Hi, You are one of the person for responsible for project - #{project.name}"
    mail(to: to_list, subject: subject, body: body)
  end
end
