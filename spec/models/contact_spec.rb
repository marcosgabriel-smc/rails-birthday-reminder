require 'rails_helper'

RSpec.describe Contact, type: :model do
  context 'validations' do
    it 'is invalid without a name' do
      contact = build(:contact, name: nil)
      expect(contact).not_to be_valid
      expect(contact.errors[:name]).to include("não pode ficar em branco")
    end

    it 'is invalid without a birthday' do
      contact = build(:contact, birthday: nil)
      expect(contact).not_to be_valid
      expect(contact.errors[:birthday]).to include("não pode ficar em branco")
    end

    it 'is valid with a name and a birthday' do
      contact = build(:contact)
      expect(contact).to be_valid
    end
  end

  context 'associations' do
    it 'belongs to a user' do
      expect(Contact.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end

  context 'scopes' do
    before do
      @user = create(:user)
      @contact1 = create(:contact, user: @user, name: 'Joao', birthday: '1990-01-01')
      @contact2 = create(:contact, user: @user, name: 'Maria', birthday: '1990-02-01')
    end

    it 'groups contacts by month' do
      grouped_contacts = Contact.group_contacts_by_month([@contact1, @contact2])
      expect(grouped_contacts[:january]).to include(@contact1)
      expect(grouped_contacts[:february]).to include(@contact2)
    end
  end
end
