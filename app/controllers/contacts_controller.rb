class ContactsController < ApplicationController
  def index
    @contacts = policy_scope(Contact)
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
end
