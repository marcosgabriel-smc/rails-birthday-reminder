class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  before_create :generate_shareable_token

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contacts, dependent: :destroy

  validates :telegram_id, presence: true
  validates :shareable_token, uniqueness: true

  def generate_shareable_token
    self.shareable_token = Devise.friendly_token
  end
end
