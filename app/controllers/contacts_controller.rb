class ContactsController < ApplicationController
  before_action :set_contact, only: %i[update destroy]
  before_action :authorize_user, except: %i[index]
  before_action :set_contacts_and_user, only: %i[index create update]

  def index
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user = @user
    if @contact.save
      redirect_to contacts_path, notice: 'Aniversariante adicionado'
    else
      flash.now[:alert] = 'Não foi possível criar o aniversariante'
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      redirect_to contacts_path, notice: 'Aniversariante atualizado.'
    else
      flash.now[:alert] = 'Não foi possível atualizar o aniversariante'
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path notice: 'Aniversariante excluído'
  end

  def telegram_login
    telegram_id = params[:id]

    user = User.find_by(telegram_id: telegram_id)

    if user
      sign_in(user)
      redirect_to contacts_path, notice: 'Acesso via Telegram realizado'
    else
      @new_user = User.new(
        telegram_id: params[:id],
        first_name: params[:first_name],
        last_name: params[:last_name]
      )
      render 'devise/registrations/new'
    end
  end

  def send_message
    TelegramMailer.send_birthday_message.deliver_now
    redirect_to contacts_path, notice: 'Messages delivered.'
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

  def set_contacts_and_user
    @user = current_user
    if params[:query].present?
      @contacts = policy_scope(Contact).search_by_name(params[:query])
    else
      @contacts = policy_scope(Contact)
    end

    @grouped_contacts = Contact.group_contacts_by_month(@contacts)
  end
end
