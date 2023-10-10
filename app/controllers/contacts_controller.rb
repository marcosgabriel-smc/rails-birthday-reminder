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
