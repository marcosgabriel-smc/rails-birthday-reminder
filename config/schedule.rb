# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, File.expand_path('../cron_log.log', __FILE__)
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 3.minutes do
  runner "TelegramMailer.send_birthday_message.deliver_now", environment: 'development'
end

every 3.minutes do
  rake 'birthday_mailer:send_messages'
end
