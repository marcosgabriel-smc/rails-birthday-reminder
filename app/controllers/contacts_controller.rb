class ContactsController < ApplicationController
  before_action :authorize_user, except: %i[index]

  def index
    @user = current_user
    @contacts = policy_scope(Contact)
    @new_contact = Contact.new
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def authorize_user
    contact = @contact || Contact
    authorize contact
  end

end
