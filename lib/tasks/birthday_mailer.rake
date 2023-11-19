namespace :birthday_mailer do
  desc "Send birthday messages"
  task send_messages: :environment do
    TelegramMailer.send_birthday_message.deliver_now
    puts "Messages delivered"
  end

  # UPDATE THIS METHOD
  desc "Update shareable token"
  task update_token: :environment do
    User.all.each do |user|
      user.generate_shareable_token
      user.save
    end
    puts "Token Updated"
  end

end
