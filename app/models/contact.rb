class Contact < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :birthday, presence: true
  validates :name, uniqueness: { scope: :user_id, notice: 'Já existe um contato com essas informações' }

  def self.today_birthdays
    where('EXTRACT(month FROM birthday) = ? AND EXTRACT(day FROM birthday) = ?', Date.today.month, Date.today.day)
  end

  def self.group_contacts_by_month(contacts)
    sorted_contacts = contacts.sort_by { |contact| [contact.birthday.month, contact.birthday.day] }

    contacts_map = {
      january: [],
      february: [],
      march: [],
      april: [],
      may: [],
      june: [],
      july: [],
      august: [],
      september: [],
      october: [],
      november: [],
      december: []
    }

    sorted_contacts.each do |contact|
      month_name = contact.birthday.strftime('%B').downcase.to_sym
      contacts_map[month_name] << contact
    end

    contacts_map
  end

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [:name],
    using: {
      tsearch: { prefix: true}
    }
end
