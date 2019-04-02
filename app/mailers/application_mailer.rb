class ApplicationMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  default from: ENV['ENAVIGATOR_USER_ADDRESS']
  layout 'mailer'
end
