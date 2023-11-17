set :output, "#{__dir__}/cron_log.log"


# every 3.minutes do
#   runner "TelegramMailer.send_birthday_message.deliver_now", environment: 'development'
# end

# every 3.minutes do
#   rake 'birthday_mailer:send_messages'
# end

every 1.minute do
  command "echo 'let's go'"
end
