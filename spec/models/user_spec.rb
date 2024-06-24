require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    before do
      User.skip_callback(:create, :before, :generate_shareable_token)
    end

    after do
      User.set_callback(:create, :before, :generate_shareable_token)
    end

    it 'is invalid without a telegram_id' do
      user = build(:user, telegram_id: nil)
      expect(user).not_to be_valid
      expect(user.errors[:telegram_id]).to include("não pode ficar em branco")
    end

    it 'is invalid with a duplicate telegram_id' do
      create(:user, telegram_id: '12345')
      user = build(:user, telegram_id: '12345')
      expect(user).not_to be_valid
      expect(user.errors[:telegram_id]).to include('já está em uso')
    end

    it 'is invalid with a duplicate shareable_token' do
      create(:user, shareable_token: 'token123')
      user2 = build(:user, email: 'teste@teste.com', telegram_id: '54321', shareable_token: 'token123')
      expect(user2).not_to be_valid
      expect(user2.errors[:shareable_token]).to include('já está em uso')
    end

    it 'is valid with a unique telegram_id and shareable_token' do
      user = build(:user, telegram_id: '12345', shareable_token: 'token123')
      expect(user).to be_valid
    end
  end

  context 'associations' do
    it 'has many contacts' do
      association = User.reflect_on_association(:contacts)
      expect(association.macro).to eq(:has_many)
    end

    it 'destroys associated contacts when the user is destroyed' do
      user = create(:user)
      user.contacts.create(name: 'Contact1', birthday: '1990-01-01')
      expect { user.destroy }.to change { Contact.count }.by(-1)
    end
  end

  context 'callbacks' do
    it 'generates a shareable token before creation' do
      user = build(:user)
      expect(user.shareable_token).to be_nil
      user.save
      expect(user.shareable_token).not_to be_nil
    end
  end

  context 'class methods' do
    it 'updates tokens for all users' do
      user1 = create(:user, shareable_token: 'token1')
      user2 = create(:user, email: 'teste@teste.com', telegram_id: '54321', shareable_token: 'token2')
      old_token1 = user1.shareable_token
      old_token2 = user2.shareable_token
      User.update_tokens
      user1.reload
      user2.reload
      expect(user1.shareable_token).not_to eq(old_token1)
      expect(user2.shareable_token).not_to eq(old_token2)
    end
  end
end
