namespace :birthday_mailer do
  desc "Send birthday messages"
  task send_messages: :environment do
    TelegramMailer.send_birthday_message.deliver_now
    puts "Messages delivered"
  end
end
