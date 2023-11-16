class ShareableLinkController < ApplicationController
  before_action :authenticate_user!

  def show
    authorize :shareable_link, :show?
    @user = current_user
    @sharing_user = User.find_by(shareable_token: params[:id])
    @contacts = @sharing_user.contacts if @sharing_user.present?

    if params[:query].present? && @sharing_user.present?
      current_user_contacts = current_user.contacts.pluck(:name, :birthday)
      @contacts = @sharing_user.contacts.where.not(name: current_user_contacts.map(&:first), birthday: current_user_contacts.map(&:last)).search_by_name(params[:query])
    elsif @sharing_user.present?
      current_user_contacts = current_user.contacts.pluck(:name, :birthday)
      @contacts = @sharing_user.contacts.where.not(name: current_user_contacts.map(&:first), birthday: current_user_contacts.map(&:last))
    else
      error_not_found
    end
  end

  def create
    authorize :shareable_link, :create?

    shared_contact = Contact.find(params[:contact_id])

    # Create a new contact instance for the current user using the information from the shared contact
    new_contact = Contact.new(
      name: shared_contact.name,
      birthday: shared_contact.birthday,
      user: current_user
    )

    if new_contact.save
      render json: { success: true, message: 'Aniversariante adicionado!' }
    else
      render json: { success: false, message: 'Já existe um aniversariante com essas informações.' }, status: :unprocessable_entity
    end
  end
end
