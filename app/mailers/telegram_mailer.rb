class TelegramMailer < ApplicationMailer

  def send_birthday_message
    @birthdays = Contact.today_birthdays

    @birthdays.each do |birthday|
      text = "#{birthday.user.first_name}, hoje é o aniversário de #{birthday.name}"
      chat_id = birthday.user.telegram_id
      HTTParty.post("https://api.telegram.org/bot#{ENV['BOT_TOKEN']}/sendMessage",
        headers: {
          'Content-Type' => 'application/json'
        },
        body: {
          chat_id: chat_id,
          text: text
        }.to_json)
    end
  end
end
