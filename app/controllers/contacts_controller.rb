class ContactsController < ApplicationController
  before_action :set_contact, only: %i[update destroy]
  before_action :authorize_user, except: %i[index]

  def index
    @user = current_user
    @contacts = policy_scope(Contact)
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user = current_user
    if @contact.save
      redirect_to contacts_path, notice: 'Contact was successfully created.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      redirect_to contacts_path, notice: "Contact was successfully updated."
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy

    redirect_to contacts_path notice: "Contact was successfully destroyed."
  end

  def birthday_message
    @user = current_user
    @contacts = policy_scope(Contact)
    @birthdays = @contacts.today_birthdays

    @birthday.for_each do |birthday|
      text = "#{@user.first_name}, hoje é o aniversário do #{birthday.name}"
      chat_id = @user.chat_id
      HTTParty.post("https://api.telegram.org/bot#{BOT_TOKEN}/sendMessage",
        headers: {
          'Content-Type' => 'application/json'
        },
        body: {
          chat_id: chat_id,
          text: text
        }.to_json)
    end
    redirect_to contacts_path, notice: "sucess"
  end

  def telegram_login
    # Extract the Telegram ID from the authentication response
    telegram_id = params[:id]

    # Find the user with the matching Telegram ID
    user = User.find_by(telegram_id: telegram_id)

    if user
      sign_in(user) # Create a user session
      redirect_to contacts_path, notice: 'Logged in successfully via Telegram.'
    else
      redirect_to new_user_registration_path, alert: 'Telegram login failed. User not found.'
    end
  end

  private

  def authorize_user
    contact = @contact || Contact
    authorize contact
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :birthday)
  end
end
