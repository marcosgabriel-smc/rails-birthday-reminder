class ApplicationMailer < ActionMailer::Base
  default from: ENV['APPLICATION_EMAIL']
  layout 'mailer'
end
